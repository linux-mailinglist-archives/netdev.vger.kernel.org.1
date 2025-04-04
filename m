Return-Path: <netdev+bounces-179408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF20AA7C628
	for <lists+netdev@lfdr.de>; Sat,  5 Apr 2025 00:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE2E172871
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 22:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B12919E998;
	Fri,  4 Apr 2025 22:05:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD514689;
	Fri,  4 Apr 2025 22:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743804317; cv=none; b=S9moG7udqXReOtaTP3VVn2mXieucKy0C+YRKt10YcyRkQzc6YtB/9dRp9nOCuCaT9rLmrWspXauEMUGLK8wM0fPkBMRPUXNHV6AS1sk98TvaRPTaeQ/2M2dI3cfY390qmJsxaREeursI0FhJADLU0AL7t8S3vP5ePShmg0FOeas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743804317; c=relaxed/simple;
	bh=NQb8QRU2q3flJql7F4O6wzu4m0gUW38uFyjUaUzKznI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iALaMjwTaXWvFSN6Mt51eQNtzJ8+Fp0M0yoGyDuFTcAlAxZFGPnCjtGwfVLOs6hQx2kXO6zf+3ADSi4SawNSGHduygjy+nzKaqta5XN59FSZ9ILRjM+GWJ6gfXP74COoVHgiK4AQoMhrdD8IuaNMmtNceUZyGE2eoBW7D536Psk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso23453375e9.1;
        Fri, 04 Apr 2025 15:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743804313; x=1744409113;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4flYMgBhFeJhObgzKMwspMZZsPDbsL3222BuxIrtZ1w=;
        b=FJaH0lAVimYvNMM7IsnDH04Za7Zsg2fYwmEriskQgfZeQfc86naLICLrkSGLiqZZcz
         qbH3DFFXhF8mPUzZ1ggGY67ujUTKrTY7o1d0nnAi7fpxUoGzgOv1BE2gOCDseOUmbaVO
         qSFHsvBv+bWRCYB1U7lq0MFH0KFZBD5n7cHpj/gng3gQ5anVIEgXtBb/nIkKJirICMlX
         EJMLC+BglGpb64oTSufaNXipoaoIyHFglRm3tBXR2kQDf+GPhB4RmAO9qd6/2eXru9aY
         ++J6xovaCCD/l7Jz6FhYIn9mwdjA3TWNPh6hkeISEeCEhu5aeMQpIiCMUvdw3hBg3YYg
         O59w==
X-Forwarded-Encrypted: i=1; AJvYcCWYV/dgqRO3n6MzHkgLOvukvh/H3d8IZSrddftBMFGyGrhP3ViNCz5QmbReGwoqeUULavZzrmOC@vger.kernel.org, AJvYcCXO1AKuu9DFzApkycv84T0ituJPhgTiLz+u+n/n4/6N6WmKrerXhd6GcX34L1ef27nUEtKbjHF932lswMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpzJ8mqdZm7A5MrXXy3usPquL1Ghr2+8zrdq1nDVtx4ixCZFbs
	zJTjcjr7HgYd7XXA9e8y2DAAhuXZaW1eH8/DPO9U1jHR99jsG1tq
X-Gm-Gg: ASbGncsuE8gTaVIWRk6Hvi+viT4+xPPj0quvM2KapEcMv/LtcJdEPNYCEzdze+7EHoJ
	gEfInrd4Qh9l3KocNeNfqAsiqBjQmDYxfvgPV2HTbCHo65fz5vhT614wG3Vicqpc+Z9apBTSZtT
	8lNo7EFPmD5NukpYLJRV7mkpm4G+hUKH8BaUd3BMoSUNjAkknIJwLwX0eQ5teqAjzKvtSSiclpI
	7lSUKVX/IoGTr7xXq49UEPPg4eP8Vybym/y7CTXuc3YlBbnzWqmhm5bSCyPPfmo6Px0ydhzLsnW
	9kUcMlh4lPnyWEC8jPvqi03mz5QXUGSyXXCMmMeKrud/EinDv6Woy3KVmJkqduulzEqiTRwCQdq
	c3w==
X-Google-Smtp-Source: AGHT+IHzFUlbTGz8j0vcRxTxtpDT/OrTAjMVEEJmCbYc8vdVu8DIV6HSlfCRNn8cTj0OVwzz4XrR4w==
X-Received: by 2002:a05:600c:444b:b0:43c:fffc:7855 with SMTP id 5b1f17b1804b1-43ecf8f2a65mr43427595e9.15.1743804312776;
        Fri, 04 Apr 2025 15:05:12 -0700 (PDT)
Received: from [192.168.0.234] (ip-86-49-44-151.bb.vodafone.cz. [86.49.44.151])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec1795243sm60291295e9.32.2025.04.04.15.05.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Apr 2025 15:05:12 -0700 (PDT)
Message-ID: <d50c0384-4607-4890-8012-e2e7032a5354@ovn.org>
Date: Sat, 5 Apr 2025 00:05:10 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Massive virtio-net throughput drop in guest VM with
 Linux 6.8+
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Markus Fohrer <markus.fohrer@webked.de>, "Michael S. Tsirkin"
 <mst@redhat.com>
Cc: virtualization@lists.linux-foundation.org, jasowang@redhat.com,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, i.maximets@ovn.org
References: <1d388413ab9cfd765cd2c5e05b5e69cdb2ec5a10.camel@webked.de>
 <20250403090001-mutt-send-email-mst@kernel.org>
 <11c5cb52d024a5158c5b8c5e69e2e4639a055a31.camel@webked.de>
 <20250404042711-mutt-send-email-mst@kernel.org>
 <e75cb5881a97485b08cdd76efd8a7d2191ecd106.camel@webked.de>
 <3b02f37ee12232359672a6a6c2bccaa340fbb6ff.camel@webked.de>
 <67eff7303df69_1ddca829490@willemb.c.googlers.com.notmuch>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <67eff7303df69_1ddca829490@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/4/25 5:13 PM, Willem de Bruijn wrote:
> Markus Fohrer wrote:
>> Am Freitag, dem 04.04.2025 um 10:52 +0200 schrieb Markus Fohrer:
>>> Am Freitag, dem 04.04.2025 um 04:29 -0400 schrieb Michael S. Tsirkin:
>>>> On Fri, Apr 04, 2025 at 10:16:55AM +0200, Markus Fohrer wrote:
>>>>> Am Donnerstag, dem 03.04.2025 um 09:04 -0400 schrieb Michael S.
>>>>> Tsirkin:
>>>>>> On Wed, Apr 02, 2025 at 11:12:07PM +0200, Markus Fohrer wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> I'm observing a significant performance regression in KVM
>>>>>>> guest
>>>>>>> VMs
>>>>>>> using virtio-net with recent Linux kernels (6.8.1+ and 6.14).
>>>>>>>
>>>>>>> When running on a host system equipped with a Broadcom
>>>>>>> NetXtreme-E
>>>>>>> (bnxt_en) NIC and AMD EPYC CPUs, the network throughput in
>>>>>>> the
>>>>>>> guest drops to 100–200 KB/s. The same guest configuration
>>>>>>> performs
>>>>>>> normally (~100 MB/s) when using kernel 6.8.0 or when the VM
>>>>>>> is
>>>>>>> moved to a host with Intel NICs.
>>>>>>>
>>>>>>> Test environment:
>>>>>>> - Host: QEMU/KVM, Linux 6.8.1 and 6.14.0
>>>>>>> - Guest: Linux with virtio-net interface
>>>>>>> - NIC: Broadcom BCM57416 (bnxt_en driver, no issues at host
>>>>>>> level)
>>>>>>> - CPU: AMD EPYC
>>>>>>> - Storage: virtio-scsi
>>>>>>> - VM network: virtio-net, virtio-scsi (no CPU or IO
>>>>>>> bottlenecks)
>>>>>>> - Traffic test: iperf3, scp, wget consistently slow in guest
>>>>>>>
>>>>>>> This issue is not present:
>>>>>>> - On 6.8.0 
>>>>>>> - On hosts with Intel NICs (same VM config)
>>>>>>>
>>>>>>> I have bisected the issue to the following upstream commit:
>>>>>>>
>>>>>>>   49d14b54a527 ("virtio-net: Suppress tx timeout warning for
>>>>>>> small
>>>>>>> tx")
>>>>>>>   https://git.kernel.org/linus/49d14b54a527
>>>>>>
>>>>>> Thanks a lot for the info!
>>>>>>
>>>>>>
>>>>>> both the link and commit point at:
>>>>>>
>>>>>> commit 49d14b54a527289d09a9480f214b8c586322310a
>>>>>> Author: Eric Dumazet <edumazet@google.com>
>>>>>> Date:   Thu Sep 26 16:58:36 2024 +0000
>>>>>>
>>>>>>     net: test for not too small csum_start in
>>>>>> virtio_net_hdr_to_skb()
>>>>>>     
>>>>>>
>>>>>> is this what you mean?
>>>>>>
>>>>>> I don't know which commit is "virtio-net: Suppress tx timeout
>>>>>> warning
>>>>>> for small tx"
>>>>>>
>>>>>>
>>>>>>
>>>>>>> Reverting this commit restores normal network performance in
>>>>>>> affected guest VMs.
>>>>>>>
>>>>>>> I’m happy to provide more data or assist with testing a
>>>>>>> potential
>>>>>>> fix.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Markus Fohrer
>>>>>>
>>>>>>
>>>>>> Thanks! First I think it's worth checking what is the setup,
>>>>>> e.g.
>>>>>> which offloads are enabled.
>>>>>> Besides that, I'd start by seeing what's doing on. Assuming I'm
>>>>>> right
>>>>>> about
>>>>>> Eric's patch:
>>>>>>
>>>>>> diff --git a/include/linux/virtio_net.h
>>>>>> b/include/linux/virtio_net.h
>>>>>> index 276ca543ef44d8..02a9f4dc594d02 100644
>>>>>> --- a/include/linux/virtio_net.h
>>>>>> +++ b/include/linux/virtio_net.h
>>>>>> @@ -103,8 +103,10 @@ static inline int
>>>>>> virtio_net_hdr_to_skb(struct
>>>>>> sk_buff *skb,
>>>>>>  
>>>>>>  		if (!skb_partial_csum_set(skb, start, off))
>>>>>>  			return -EINVAL;
>>>>>> +		if (skb_transport_offset(skb) < nh_min_len)
>>>>>> +			return -EINVAL;
>>>>>>  
>>>>>> -		nh_min_len = max_t(u32, nh_min_len,
>>>>>> skb_transport_offset(skb));
>>>>>> +		nh_min_len = skb_transport_offset(skb);
>>>>>>  		p_off = nh_min_len + thlen;
>>>>>>  		if (!pskb_may_pull(skb, p_off))
>>>>>>  			return -EINVAL;
>>>>>>
>>>>>>
>>>>>> sticking a printk before return -EINVAL to show the offset and
>>>>>> nh_min_len
>>>>>> would be a good 1st step. Thanks!
>>>>>>
>>>>>
>>>>> I added the following printk inside virtio_net_hdr_to_skb():
>>>>>
>>>>>     if (skb_transport_offset(skb) < nh_min_len){
>>>>>         printk(KERN_INFO "virtio_net: 3 drop,
>>>>> transport_offset=%u,
>>>>> nh_min_len=%u\n",
>>>>>                skb_transport_offset(skb), nh_min_len);
>>>>>         return -EINVAL;
>>>>>     }
>>>>>
>>>>> Built and installed the kernel, then triggered a large download
>>>>> via:
>>>>>
>>>>>     wget http://speedtest.belwue.net/10G
>>>>>
>>>>> Relevant output from `dmesg -w`:
>>>>>
>>>>> [   57.327943] virtio_net: 3 drop, transport_offset=34,
>>>>> nh_min_len=40  
>>>>> [   57.428942] virtio_net: 3 drop, transport_offset=34,
>>>>> nh_min_len=40  
>>>>> [   57.428962] virtio_net: 3 drop, transport_offset=34,
>>>>> nh_min_len=40  
>>>>> [   57.553068] virtio_net: 3 drop, transport_offset=34,
>>>>> nh_min_len=40  
>>>>> [   57.553088] virtio_net: 3 drop, transport_offset=34,
>>>>> nh_min_len=40  
>>>>> [   57.576678] virtio_net: 3 drop, transport_offset=34,
>>>>> nh_min_len=40  
>>>>> [   57.618438] virtio_net: 3 drop, transport_offset=34,
>>>>> nh_min_len=40  
>>>>> [   57.618453] virtio_net: 3 drop, transport_offset=34,
>>>>> nh_min_len=40  
>>>>> [   57.703077] virtio_net: 3 drop, transport_offset=34,
>>>>> nh_min_len=40  
>>>>> [   57.823072] virtio_net: 3 drop, transport_offset=34,
>>>>> nh_min_len=40  
>>>>> [   57.891982] virtio_net: 3 drop, transport_offset=34,
>>>>> nh_min_len=40  
>>>>> [   57.946190] virtio_net: 3 drop, transport_offset=34,
>>>>> nh_min_len=40  
>>>>> [   58.218686] virtio_net: 3 drop, transport_offset=34,
>>>>> nh_min_len=40  
>>>>
>>>> Hmm indeed. And what about these values?
>>>>                 u32 start = __virtio16_to_cpu(little_endian, hdr-
>>>>> csum_start);
>>>>                 u32 off = __virtio16_to_cpu(little_endian, hdr-
>>>>> csum_offset);
>>>>                 u32 needed = start + max_t(u32, thlen, off +
>>>> sizeof(__sum16));
>>>> print them too?
>>>>
>>>>
>>>>
>>>>> I would now do the test with commit
>>>>> 49d14b54a527289d09a9480f214b8c586322310a and commit
>>>>> 49d14b54a527289d09a9480f214b8c586322310a~1
>>>>>
>>>>
>>>> Worth checking though it seems likely now the hypervisor is doing
>>>> weird
>>>> things. what kind of backend is it? qemu? tun? vhost-user? vhost-
>>>> net?
>>>>
>>>
>>> Backend: QEMU/KVM hypervisor (Proxmox)
>>>
>>>
>>> printk output:
>>>
>>> [   58.641906] virtio_net: drop, transport_offset=34  start=34,
>>> off=16,
>>> needed=54, nh_min_len=40
>>> [   58.678048] virtio_net: drop, transport_offset=34  start=34,
>>> off=16,
>>> needed=54, nh_min_len=40
>>> [   58.952871] virtio_net: drop, transport_offset=34  start=34,
>>> off=16,
>>> needed=54, nh_min_len=40
>>> [   58.962157] virtio_net: drop, transport_offset=34  start=34,
>>> off=16,
>>> needed=54, nh_min_len=40
>>> [   59.071645] virtio_net: drop, transport_offset=34  start=34,
>>> off=16,
>>> needed=54, nh_min_len=40
> 
> So likely a TCP/IPv4 packet, but with VIRTIO_NET_HDR_GSO_TCPV6.


Hi, Markus.

Given this and the fact that the issue depends on the bnxt_en NIC on the
hist, I'd make an educated guess that the problem is the host NIC driver.

There are some known GRO issues in the nbxt_en driver fixed recently in

  commit de37faf41ac55619dd329229a9bd9698faeabc52
  Author: Michael Chan <michael.chan@broadcom.com>
  Date:   Wed Dec 4 13:59:17 2024 -0800

    bnxt_en: Fix GSO type for HW GRO packets on 5750X chips

It's not clear to me what's your host kernel version.  But the commit
above was introduced in 6.14 and may be in fairly recent stable kernels.
The oldest is v6.12.6 AFAICT.  Can you try one of these host kernels?

Also, to confirm and workaround the problem, please, try disabling HW GRO
on the bnxt_en NIC first:

  ethtool -K <BNXT_EN NIC IFACE> rx-gro-hw off

If that doesn't help, then the problem is likely something different.

Best regards, Ilya Maximets.

> 
> This is observed in the guest on the ingress path, right? In
> virtnet_receive_done.
> 
> Is this using vhost-net in the host for pass-through? IOW, is
> the host writing the virtio_net_hdr too?
> 
>>>
>>>
>>>
>>>
>>
>> I just noticed that commit 17bd3bd82f9f79f3feba15476c2b2c95a9b11ff8
>> (tcp_offload.c: gso fix) also touches checksum handling and may
>> affect how skb state is passed to virtio_net_hdr_to_skb().
>>
>> Is it possible that the regression only appears due to the combination
>> of 17bd3bd8 and 49d14b54a5?
> 
> That patch only affects packets with SKB_GSO_FRAGLIST. Which is only
> set on forwarding if NETIF_F_FRAGLIST is set. I don 


