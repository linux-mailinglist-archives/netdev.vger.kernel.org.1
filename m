Return-Path: <netdev+bounces-83227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9651889168C
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CD91C2230B
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 10:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6224A524D3;
	Fri, 29 Mar 2024 10:10:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC086524AA;
	Fri, 29 Mar 2024 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711707034; cv=none; b=j1uyf9TDKIu8+NNax/3+z2oYW9Xr2mAacr0cACa1h+m3FBoH+CzYxqls2r34Z4CMrTHvk2cquZVt9+2hoNBQNEhgjeqb2ytuZ27k2AQXt66ZNWeZipYUpVJyAXdzkSD/SRPsIpN7gwEG8LUYUNxQYMDG7QKKXG/iFlLHhQRHY84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711707034; c=relaxed/simple;
	bh=w7g6I0XBH1zUDRQIq3sT4lHswdF1zZZjTZgR0tQTy28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C6r6IIsDGbeu7nN9BrdoXwuyi0/JJhVhzoZYhYgMIXOc6e6AO6W7Rb9m74R9gVqKCzgQpm3bv4SNtd0AskZ1AgPq8nKRXhITtKsNfbOaolSoBWGmnNAFMK10z+to899o8musWSTk5CCFh0qS+DuhHLc3E3cjytoPnereJO0LIUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V5bkl4ZRNz4f3jkg;
	Fri, 29 Mar 2024 18:10:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id B82E91A12A3;
	Fri, 29 Mar 2024 18:10:27 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP3 (Coremail) with SMTP id _Ch0CgCnaKCPkwZm3Js0IQ--.42308S2;
	Fri, 29 Mar 2024 18:10:23 +0800 (CST)
Message-ID: <e995a1f1-0b48-4ce3-a061-5cbe68beb6dd@huaweicloud.com>
Date: Fri, 29 Mar 2024 18:10:23 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/5] Support local vmtest for riscv64
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org,
 linux-riscv@lists.infradead.org, netdev@vger.kernel.org
Cc: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Mykola Lysenko <mykolal@fb.com>, Manu Bretelle <chantr4@gmail.com>,
 Pu Lehui <pulehui@huawei.com>
References: <20240328124916.293173-1-pulehui@huaweicloud.com>
 <32b3358903bf8ba408812a2636f39a275493eb91.camel@gmail.com>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <32b3358903bf8ba408812a2636f39a275493eb91.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgCnaKCPkwZm3Js0IQ--.42308S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur1Uur1rtFyxWFW3tF1fWFg_yoW5KrWfpr
	WrA3ZakF1kXF17tF1xGa1DuF42qwn5ta17Ww18G34rua1qyFnYgFsYya10gay3Zw4UGw4Y
	ya9IgFyYkFn5u3JanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UdxhLUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2024/3/29 17:08, Eduard Zingerman wrote:
> On Thu, 2024-03-28 at 12:49 +0000, Pu Lehui wrote:
>> Patch 1 is to enable cross platform testing for local vmtest. The
>> remaining patch adds local vmtest support for riscv64. It relies on
>> commit [0] [1] for better regression.
>>
>> We can now perform cross platform testing for riscv64 bpf using the
>> following command:
>>
>> PLATFORM=riscv64 CROSS_COMPILE=riscv64-linux-gnu- \
>>      tools/testing/selftests/bpf/vmtest.sh -- \
>>          ./test_progs -d \
>>              \"$(cat tools/testing/selftests/bpf/DENYLIST.riscv64 \
>>                  | cut -d'#' -f1 \
>>                  | sed -e 's/^[[:space:]]*//' \
>>                        -e 's/[[:space:]]*$//' \
>>                  | tr -s '\n' ','\
>>              )\"
>>
>> The test platform is x86_64 architecture, and the versions of relevant
>> components are as follows:
>>      QEMU: 8.2.0
>>      CLANG: 17.0.6 (align to BPF CI)
>>      OpenSBI: 1.3.1 (default by QEMU)
>>      ROOTFS: ubuntu jammy (generated by [2])
>>
>> Link: https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?id=ea6873118493 [0]
>> Link: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=443574b033876c85 [1]
>> Link: https://github.com/libbpf/ci/blob/main/rootfs/mkrootfs_debian.sh [2]
> 
> Hello,
> 
> I wanted to do a test run for this patch-set but did not figure out
> how to build rootfs for riscv64 system.
> 
> I modified mkrootfs_debian.sh as below, but build command fails:
> 
> $ ./rootfs/mkrootfs_debian.sh -d jammy -a riscv64 -m http://de.archive.ubuntu.com/ubuntu
> ...
> E: Couldn't download http://de.archive.ubuntu.com/ubuntu/dists/jammy/main/binary-riscv64/Packages
> 
> Apparently jammy does not have binaries built for riscv64, or I'm failing to find correct mirror.
> Could you please provide some instructions on how to prepare rootfs?

Hi Eduard, We need the mirror repository of ubuntu-ports, you could try 
http://de.ports.ubuntu.com/.

> 
> Thanks,
> Eduard
> 
> --
> 
> diff --git a/rootfs/mkrootfs_debian.sh b/rootfs/mkrootfs_debian.sh
> index dfe957e..1d5b769 100755
> --- a/rootfs/mkrootfs_debian.sh
> +++ b/rootfs/mkrootfs_debian.sh
> @@ -16,6 +16,7 @@ CPUTABLE="${CPUTABLE:-/usr/share/dpkg/cputable}"
>   
>   deb_arch=$(dpkg --print-architecture)
>   distro="bullseye"
> +mirror=""
>   
>   function usage() {
>       echo "Usage: $0 [-a | --arch architecture] [-h | --help]
> @@ -25,6 +26,7 @@ By default build an image for the architecture of the host running the script.
>   
>       -a | --arch:    architecture to build the image for. Default (${deb_arch})
>       -d | --distro:  distribution to build. Default (${distro})
> +    -m | --mirror:  mirror for distribution to build. Default (${mirror})
>   "
>   }
>   
> @@ -44,7 +46,7 @@ function qemu_static() {
>       # Given a Debian architecture find the location of the matching
>       # qemu-${gnu_arch}-static binary.
>       gnu_arch=$(debian_to_gnu "${1}")
> -    echo "qemu-${gnu_arch}-static"
> +    echo "qemu-${gnu_arch}"
>   }
>   
>   function check_requirements() {
> @@ -95,7 +97,7 @@ function check_requirements() {
>       fi
>   }
>   
> -TEMP=$(getopt  -l "arch:,distro:,help" -o "a:d:h" -- "$@")
> +TEMP=$(getopt  -l "arch:,distro:,mirror:,help" -o "a:d:m:h" -- "$@")
>   if [ $? -ne 0 ]; then
>       usage
>   fi
> @@ -113,6 +115,10 @@ while true; do
>               distro="$2"
>               shift 2
>               ;;
> +        --mirror | -m)
> +            mirror="$2"
> +            shift 2
> +            ;;
>           --help | -h)
>               usage
>               exit
> @@ -162,7 +168,8 @@ debootstrap --include="$packages" \
>       --arch="${deb_arch}" \
>       "$@" \
>       "${distro}" \
> -    "$root"
> +    "$root" \
> +    "${mirror}"
>   
>   qemu=$(which $(qemu_static ${deb_arch}))
>   


