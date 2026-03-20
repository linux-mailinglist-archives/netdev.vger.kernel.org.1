Return-Path: <netdev+bounces-269999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CaAAhKGvWnQ+gIAu9opvQ
	(envelope-from <netdev+bounces-269999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:38:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E442DEC70
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 18:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A6153015D2E
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 17:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94753BD22C;
	Fri, 20 Mar 2026 17:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="CNc1fM/7"
X-Original-To: netdev@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D502D2F546D;
	Fri, 20 Mar 2026 17:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774027880; cv=none; b=aCz4VSvOotDd0+HaThPw6pYxeat8mIoNboCJ5XDP1gfB4MRCxflQgiu1tM9E3K1W02rWf52goeOn2ViVaebN2XbJqmtVVVd7OwWbEESuIkcpQXx8pfistOoSVNHcurklgvqCNLw8T2IQwW5Y1z+Z0jAxcq1NO+DMo2j6kycn4+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774027880; c=relaxed/simple;
	bh=bo2k1sA1g9MfPxmyHuLEb+Cso2UyA6+0aqAcl7dSUoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=flpezVlkmXm91s8iJ0kYtNqHNPgvNbiHzCa/hEgpkK8GN/l+A6xlShiJbHQsE3dTsJQm6UFCA5m5M342lHVHJrtOImS7tS3TRbkj73dNBrJ32CEzaVKPDVPYgGCJh7PY/I0xmd+6Yi6NI4yIIycu++X162pno9cFc53CiWHd4+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=CNc1fM/7; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=S/Cpy5yvI1C33V5zY9HjG11G/6SJpybIjlU4lHq7P5g=; b=CNc1fM/7u+lEst45vo5coTKm90
	6gdT5+WLE/BF1gvu+x/g1fr/71tkp7uT267UQ56yY/bhd6V3qbTYBW3fLi4J5qCTqWhOKNjMqCyue
	6qnuUK9ymdXMs5vGUYVB/14TUtZaI1jPYjNZTg1DO+8oIpRWKzXRpdAbFfjTSvmDCHoP2GdjJRZ+p
	hgmJirvka2QwUz+rAMpzvCYdbgs81zJD2RdSXIKM/mYU58+N6PwgUErOQAMk/aYEKYbBJUlJdgy8h
	+DYHIgXqKfSyoH567yG1mlqjO9QWcwfVRxjjbUy4o1krVg7Rv0HT+M7f5kxVZKpaulEiJxsh0gfD9
	/Ji8IBJw==;
Received: from [179.221.50.217] (helo=[192.168.0.108])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1w3dgT-003uXJ-7B; Fri, 20 Mar 2026 18:30:53 +0100
Message-ID: <270a0c7b-a917-4c1a-9b21-e8dcec4dc260@igalia.com>
Date: Fri, 20 Mar 2026 14:30:45 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KMSAN: uninit-value in eth_type_trans
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 Alexander Potapenko <glider@google.com>, Robin Murphy
 <robin.murphy@arm.com>, Christoph Hellwig <hch@infradead.org>,
 Leon Romanovsky <leonro@nvidia.com>, mhklinux@outlook.com
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 Aleksandr Nogikh <nogikh@google.com>, kernel-dev@igalia.com
References: <20250925223656.1894710-1-nogikh@google.com>
 <CAG_fn=U3Rjd_0zfCJE-vuU3Htbf2fRP_GYczdYjJJ1W5o30+UQ@mail.gmail.com>
 <CGME20251008084433eucas1p2d50387b4147f88edb8de400dcf0b0a82@eucas1p2.samsung.com>
 <CAG_fn=WUGta-paG1BgsGRoAR+fmuCgh3xo=R3XdzOt_-DqSdHw@mail.gmail.com>
 <0d5f2179-b89b-42b6-805d-6a50d2268eca@samsung.com>
Content-Language: en-US
From: Helen Koike <koike@igalia.com>
In-Reply-To: <0d5f2179-b89b-42b6-805d-6a50d2268eca@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269999-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[samsung.com,google.com,arm.com,infradead.org,nvidia.com,outlook.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.205];
	FROM_NEQ_ENVFROM(0.00)[koike@igalia.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[igalia.com:-];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[igalia.com:mid,storage.googleapis.com:url,bootlin.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fireeye.com:url,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 98E442DEC70
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

On 10/13/25 4:31 AM, Marek Szyprowski wrote:
> On 08.10.2025 10:43, Alexander Potapenko wrote:
>> On Tue, Oct 7, 2025 at 8:51 AM Alexander Potapenko <glider@google.com> wrote:
>>> Folks, as far as I understand, dma_direct_sync_single_for_cpu() and
>>> dma_direct_sync_single_for_device() are the places where we send data
>>> to or from the device.
>>> Should we add KMSAN annotations to those functions to catch infoleaks
>>> and mark data from devices as initialized?
>> Something along the lines of:
>>
>> ======================================
>> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
>> index 0d37da3d95b65..7f59de19c1c87 100644
>> --- a/kernel/dma/swiotlb.c
>> +++ b/kernel/dma/swiotlb.c
>> @@ -42,6 +42,7 @@
>>    #include <linux/string.h>
>>    #include <linux/swiotlb.h>
>>    #include <linux/types.h>
>> +#include <linux/kmsan-checks.h>
>>    #ifdef CONFIG_DMA_RESTRICTED_POOL
>>    #include <linux/of.h>
>>    #include <linux/of_fdt.h>
>> @@ -903,10 +904,13 @@ static void swiotlb_bounce(struct device *dev,
>> phys_addr_t tlb_addr, size_t size
>>
>>                           local_irq_save(flags);
>>                           page = pfn_to_page(pfn);
>> -                       if (dir == DMA_TO_DEVICE)
>> +                       if (dir == DMA_TO_DEVICE) {
>> +                               kmsan_check_highmem_page(page, offset, sz);
>>                                   memcpy_from_page(vaddr, page, offset, sz);
>> -                       else
>> +                       } else {
>> +                               kmsan_unpoison_memory(vaddr, sz);
>>                                   memcpy_to_page(page, offset, vaddr, sz);
>> +                       }
>>                           local_irq_restore(flags);
>>
>>                           size -= sz;
>> @@ -915,8 +919,10 @@ static void swiotlb_bounce(struct device *dev,
>> phys_addr_t tlb_addr, size_t size
>>                           offset = 0;
>>                   }
>>           } else if (dir == DMA_TO_DEVICE) {
>> +               kmsan_check_memory(phys_to_virt(orig_addr), size);
>>                   memcpy(vaddr, phys_to_virt(orig_addr), size);
>>           } else {
>> +               kmsan_unpoison_memory(vaddr, size);
>>                   memcpy(phys_to_virt(orig_addr), vaddr, size);
>>           }
>>    }
>> ======================================
>>
>> should be conceptually right, but according to the comment in
>> swiotlb_tbl_map_single()
>> (https://protect2.fireeye.com/v1/url?k=837a6d67-dce15478-837be628-000babdfecba-aa25926458f9fd30&q=1&e=a3963b1b-328b-4f69-8ca5-ffd6fc777dd7&u=https%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv6.17.1%2Fsource%2Fkernel%2Fdma%2Fswiotlb.c%23L1431),
>> that function is deliberately copying the buffer to the device, even
>> when it is uninitialized - and KMSAN actually started reporting that
>> when I applied the above patch.
>>
>> How should we handle this case?
>> Not adding the kmsan_check_memory() calls will solve the problem, but
>> there might be real infoleaks that we won't detect.
>> We could unpoison the buffer before passing it to
>> swiotlb_tbl_map_single() to ignore just the first infoleak on the
>> buffer.
>> Alternatively, we could require callers to always initialize the
>> buffer passed to swiotlb_tbl_map_single().
> 
> Well, I didn't consider swiotlb a special case so far. I did a simple
> test with my PoC patch mentioned earlier in this thread with
> 'swiotlb=force' kernel parameter and I didn't observe any kmsan issues,
> but I admin that this wasn't exhaustive test.
> 
> Best regards


I just hit this issue and found this thread. So I'm sharing below my 
report in case it is useful (if not, please just ignore):

I'm easily reproducing it when trying to reproduce another unrelated 
issue[1] by syzbot on qemu[2] with torvalds/master branch, commit 
0e4f8f1a3d08 .

[1] https://syzkaller.appspot.com/bug?extid=ba80855313e6fa65717a
[2] 
https://github.com/google/syzkaller/blob/master/docs/reproducing_crashes.md#using-a-c-reproducer


To momentarily fix it (and allow me o reach my syzbot issue), I just did 
the following:

@@ -916,6 +917,12 @@ static void swiotlb_bounce(struct device *dev, 
phys_addr_t tlb_addr, size_t size
                 memcpy(vaddr, phys_to_virt(orig_addr), size);
         } else {
                 memcpy(phys_to_virt(orig_addr), vaddr, size);
+               kmsan_unpoison_memory(phys_to_virt(orig_addr), size);
         }
  }

Which, from the discussions here is obviously not the right solution.


In case it helps, see below what I'm executing:
(copy and pasted from my scripts)

* Config: 
https://syzkaller.appspot.com/text?tag=KernelConfig&x=963de479f54c6dbb
* Disk image: 
https://storage.googleapis.com/syzbot-assets/bef78207d3f7/disk-2d1373e4.raw.xz


$ gcc \
     repro.c \
     -lpthread \
     -static \
     -o repro

Running make olddefconfig …

$ make O=/$BUILD_DIR CC=clang LD=ld.lld olddefconfig

Building kernel …

$ make O=$BUILD_DIR CC=clang LD=ld.lld -j$NPROC

Starting QEMU with disk image …
SSH port: 35053

$ qemu-system-x86_64 \
     -m 8G \
     -smp 2,sockets=2,cores=1 \
     -drive file=disk.raw,format=raw \
     -net nic,model=e1000 \
     -net user,host=10.0.2.10,hostfwd=tcp::10022-:22 \
     -kernel $BUILD_DIR/arch/x86/boot/bzImage \
     -append 'root=/dev/sda1 console=ttyS0 panic_on_warn=1 
earlyprintk=serial net.ifnames=0 vsyscall=native numa=fake=2' \
     -enable-kvm \
     -nographic \
     -snapshot \
     -machine pc-q35-7.1 \
     -cpu host

$ scp \
     -P 10022 \
     repro \
     root@127.0.0.1:/root/

$ ssh -p 10022 root@127.0.0.1 'chmod +x ./repro && ./repro'


Regards,
Helen


