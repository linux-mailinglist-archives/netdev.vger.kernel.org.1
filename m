Return-Path: <netdev+bounces-83498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1C50892A53
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 11:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB661F21B32
	for <lists+netdev@lfdr.de>; Sat, 30 Mar 2024 10:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDC82838E;
	Sat, 30 Mar 2024 10:13:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64FAB67F;
	Sat, 30 Mar 2024 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711793594; cv=none; b=bSJi2sR1AN1OJJT5964TyV+iw0AFoXsFfcNNQzQqBfdurhLo6QPOMhi4QDleME/EAEI3zHec8PyMZn2F58yTv/H2wmack6HF78DqL1FnpNS6bise3Nd9D6Y7+YaQ1kyzJwXEhdAWb4jEXr53P0FqSLruQ5QTK9CGDubbLQkdGm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711793594; c=relaxed/simple;
	bh=JsC5VoUeo6qxef9ZMkY4tQtQ3yej/gi/YLd2vJTrgK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxarvLPRu+mk5ZdBc2p/IGRm2QUk0IROp6ZHdAtn1SLD5lufjD0LhzsDPh/tuPb5K0x5d0iwDRGKuSSkl9UjDJXD7+aG7B/m6uxajIuQmS7pVL+sDSBm5s94QtStuFDAFs9VG6lT4jV6WI5g+zDbCu92cB5/V3c/P4+nz0Ltgew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4V6ClD2Vwgz4f3js9;
	Sat, 30 Mar 2024 18:12:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id AD8D11A0175;
	Sat, 30 Mar 2024 18:13:02 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP1 (Coremail) with SMTP id cCh0CgBnggup5QdmbcobIg--.18079S2;
	Sat, 30 Mar 2024 18:12:59 +0800 (CST)
Message-ID: <52117f9c-b691-409f-ad2a-a25f53a9433d@huaweicloud.com>
Date: Sat, 30 Mar 2024 18:12:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/5] Support local vmtest for riscv64
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
 <e995a1f1-0b48-4ce3-a061-5cbe68beb6dd@huaweicloud.com>
 <f91237f311f183d57c4620bc2e6099df8aefccb0.camel@gmail.com>
Content-Language: en-US
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <f91237f311f183d57c4620bc2e6099df8aefccb0.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBnggup5QdmbcobIg--.18079S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWryDWry5tFy7Gw4xAFy3XFb_yoWrXw4Dpw
	4xGrnFyrW0qF1fKrn7CFyUuF42gr18G347AryrGrWakwn7JFWktFnaka4Yq39Fga90q39I
	yaySv343C3WUCa7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFDGOUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/


On 2024/3/30 3:46, Eduard Zingerman wrote:
> On Fri, 2024-03-29 at 18:10 +0800, Pu Lehui wrote:
> [...]
> 
>>> Apparently jammy does not have binaries built for riscv64, or I'm failing to find correct mirror.
>>> Could you please provide some instructions on how to prepare rootfs?
>>
>> Hi Eduard, We need the mirror repository of ubuntu-ports, you could try
>> http://de.ports.ubuntu.com/.
> 
> Hi Pu, thank you this mirrorm it works.
> 
> Unfortunately my local setup is still not good enough.
> I've installed cross-riscv64-gcc14 but it seems that a few more
> libraries are necessary, as I get the following compilation errors: >
>    $ PLATFORM=riscv64 CROSS_COMPILE=riscv64-suse-linux- ./vmtest.sh -- ./test_verifier
>    ... kernel compiles ok ...
>    ../../../../scripts/sign-file.c:25:10: fatal error: openssl/opensslv.h: No such file or directory
>       25 | #include <openssl/opensslv.h>
>          |          ^~~~~~~~~~~~~~~~~~~~
>    compilation terminated.
>      CC      /home/eddy/work/bpf-next/tools/testing/selftests/bpf/tools/build/host/libbpf/sharedobjs/bpf.o
>    In file included from nlattr.c:14:
>    libbpf_internal.h:19:10: fatal error: libelf.h: No such file or directory
>       19 | #include <libelf.h>
>    ...
> 
> Looks like I won't be able to test this patch-set, unless you have
> some writeup on how to create a riscv64 dev environment at hand.
> Sorry for the noise

Yeah, environmental issues are indeed a developer's nightmare. I will 
try to do something for the newcomers of riscv64 bpf. At present, I have 
simply built a docker local vmtest environment [0] based on Bjorn's 
riscv-cross-builder. We can directly run vmtest within this environment. 
Hopefully it will help.

Link: https://github.com/pulehui/riscv-cross-builder/tree/vmtest [0]

PS: Since the current rootfs of riscv64 is not in the INDEX, I simply 
modified vmtest.sh to support local rootfs. And we can use it by:
```
PLATFORM=riscv64 CROSS_COMPILE=riscv64-linux-gnu- \
     tools/testing/selftests/bpf/vmtest.sh -l /rootfs -- \
         ./test_progs -d \
             \"$(cat tools/testing/selftests/bpf/DENYLIST.riscv64 \
                 | cut -d'#' -f1 \
                 | sed -e 's/^[[:space:]]*//' \
                       -e 's/[[:space:]]*$//' \
                 | tr -s '\n' ','\
             )\"
```

diff --git a/tools/testing/selftests/bpf/vmtest.sh 
b/tools/testing/selftests/bpf/vmtest.sh
index f6889de9b498..17aff708c416 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -148,6 +148,21 @@ download_rootfs()
  		zstd -d | sudo tar -C "$dir" -x
  }

+load_rootfs()
+{
+	local image_dir="$1"
+	local rootfsversion="$2"
+	local dir="$3"
+
+	if ! which zstd &> /dev/null; then
+		echo 'Could not find "zstd" on the system, please install zstd'
+		exit 1
+	fi
+
+	cat "${image_dir}/libbpf-vmtest-rootfs-$rootfsversion.tar.zst" |
+		zstd -d | sudo tar -C "$dir" -x
+}
+
  recompile_kernel()
  {
  	local kernel_checkout="$1"
@@ -234,6 +249,7 @@ EOF

  create_vm_image()
  {
+	local local_image_dir="$1"
  	local rootfs_img="${OUTPUT_DIR}/${ROOTFS_IMAGE}"
  	local mount_dir="${OUTPUT_DIR}/${MOUNT_DIR}"

@@ -245,7 +261,11 @@ create_vm_image()
  	mkfs.ext4 -q "${rootfs_img}"

  	mount_image
-	download_rootfs "$(newest_rootfs_version)" "${mount_dir}"
+	if [[ "${local_image_dir}" == "" ]]; then
+		download_rootfs "$(newest_rootfs_version)" "${mount_dir}"
+	else
+		load_rootfs "${local_image_dir}" "$(newest_rootfs_version)" 
"${mount_dir}"
+	fi
  	unmount_image
  }

@@ -363,12 +383,16 @@ main()
  	local update_image="no"
  	local exit_command="poweroff -f"
  	local debug_shell="no"
+	local local_image_dir=""

-	while getopts ':hskid:j:' opt; do
+	while getopts ':hskil:d:j:' opt; do
  		case ${opt} in
  		i)
  			update_image="yes"
  			;;
+		l)
+			local_image_dir="$OPTARG"
+			;;
  		d)
  			OUTPUT_DIR="$OPTARG"
  			;;
@@ -445,7 +469,7 @@ main()
  	fi

  	if [[ "${update_image}" == "yes" ]]; then
-		create_vm_image
+		create_vm_image "${local_image_dir}"
  	fi

  	update_selftests "${kernel_checkout}" "${make_command}"


