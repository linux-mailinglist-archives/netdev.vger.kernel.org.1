Return-Path: <netdev+bounces-297678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KnlBAEhiKWo0WAMAu9opvQ
	(envelope-from <netdev+bounces-297678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:10:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 585686699B3
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 15:10:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ownrisk-dk.20251104.gappssmtp.com header.s=20251104 header.b=ueOvockl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297678-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297678-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C289D300B1D5
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F107D403AF7;
	Wed, 10 Jun 2026 13:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD40027B353
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:10:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781097027; cv=pass; b=A8qZp8ulNCicYmg16tatiZwbC55TOhjnsg0S2vz/Dw4wia/Rvc3KRuSqIgCTPeOrCsSQQonBnOse3sTjmbsHZuWeEdJakEUBdoBuZXAN2Djpbn/ehz5PZWlO5HuW9IupatXRjbsQNGpCyDMAeTdMFdAkGxcBYjBZv2+To4G/pyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781097027; c=relaxed/simple;
	bh=KSTC4k+mFyL/3WNFMO+LVJpA3iwxG32DnXcDXmUeysY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHn0xN+6XdRDs+gSfx6oaiud9Y8JxfzMoq4k3SJEa/Aw8WpMKYWOKFSkzVyX0hs1P9N155OS2ivEaQyP2Ur2IFQfM0EYOf8S/f8jNauuy3IFt3y7PtkKvu7XZYk1ph5X9zYRzRxDvpWdmxtt6G5oNiXsacKuEzduMO8MtDVtGdk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ownrisk.dk; spf=none smtp.mailfrom=ownrisk.dk; dkim=pass (2048-bit key) header.d=ownrisk-dk.20251104.gappssmtp.com header.i=@ownrisk-dk.20251104.gappssmtp.com header.b=ueOvockl; arc=pass smtp.client-ip=209.85.219.46
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8ccef25789fso46269976d6.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 06:10:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781097023; cv=none;
        d=google.com; s=arc-20240605;
        b=Dv0pErV8tff/YO9drR6USYucnB0GPMMt0UydJ0w82ezNGjlnCfBFOm2JUgSDB9bxM3
         KPbBmrBIFYmmJ5gFb4yUzb6tpe4AmjujcvG+XIuyHX0beFyePPZl47ELEXzqJs/uyOyn
         /5q2UXzbn9fTmxiqKPZK88lu3kM5xGHhAvcZMIGy3VC8byZDvoyUV6CJerJhUWU8V4C2
         7Bx/WEl1hdj41Fu2nsiHmJm/rdF6xowfO6xgaeG1pdVrpZC1F/KQj/UE7UyqkaxuWr96
         dIkYrAWexyxYmdxlFCQunT/IpCH/ykfd0U+ZEubI8WoyIxThQve3UtSORzES7dvg9rzf
         RRkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Sk9yvx8yYFR+qstLbRfhe+1164wVXZHqqAIjMOm9vvo=;
        fh=SaOnNSnHlCQ5+u/JDOQ/NfGV/l5OyacYGAOpKT/1N6c=;
        b=lGB8kq9fyOk7gHZrnNN7cr7m12XZjg2hmrl514BF1hqvh1eysAmtywlWO3tgNLpWaG
         /6cdioqV1LNZXQzCCmT7L//i7GYWcagnzg5EMtBIjEiLYPBEz2ARexP045HnLIej//Of
         xfE1Qv6VXZ5qqQFINwyndGAv9cJ3KmMPyUd0PJXslv9i7VCsi7As0ZZ3jVUj2Osi8HQH
         sKCIGIEYdtAoK4+IDl+PyjgXVJsPgDwTjqQX6GZbHc53tFVcnDRb48W4RdAomdPPmXQb
         CXsYii+LZNNjvJcv+WFpBdxyJtfyuR7nC1NEBnswwpVLbL00DAkIccXJN+tQdxlidPDg
         4jZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ownrisk-dk.20251104.gappssmtp.com; s=20251104; t=1781097023; x=1781701823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sk9yvx8yYFR+qstLbRfhe+1164wVXZHqqAIjMOm9vvo=;
        b=ueOvockl5ycP5D8P9hY+PpH1uhtyyzW5SNGOUillYesthhbZ22fL5DrW6t8ionFg0w
         yS+gWV2WtEmzeD+hgdrVHKhPyTf/reT4cnrnx0b9eEk3zTX2G25WyE+wowqXIu0A2ds6
         5nAK3EvsIL+iXOxhiX2avW+UMDFKeVPcdhKPTwPNhrpyJdcEeHfbC/3beqFrmtwsZFIt
         mYQ2MvoWVtXvm3sUM2V2bZn+KiPRaywwV6DAvENihjb4+xI2ItiQAehVXLGzCE5w0LxF
         NqCW3ePGJG0SbM42a+E51VgU+pT2ARZxna2QWbqGXyJ/IlzZ1s9yTPxEsam7jF7z6IAe
         Q6QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781097023; x=1781701823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sk9yvx8yYFR+qstLbRfhe+1164wVXZHqqAIjMOm9vvo=;
        b=fSMcg2n2q0hENsByYWFXGfgTqEuB1j59BI8dmjUhHO6IlUwQJDJzYlyP9hwoZZj+uP
         U7ApyIHlVThbNXpxJADXzDpol5rswXt4CjmsalbHXzmAMvCy7g8U1b9HLRRohmVDby6j
         YJc82OX5HsbTwvf1crqCYF80+8sbme5Ez4DLACqbqYdRDwdtfnibAPqETdhtsXqI2csg
         dUuKLGl4oUkj2IkNkBRG94enNXKf8lzumQxONMKFjri7FfQLstkL2VL9FFfY9dVBE/b0
         FJDZtfg+QuhyEyXFv2fkY+M7sNyoeeBTO05tsp9uVfUmGMO2tObqW6YjnXHVL3crpAV2
         e56w==
X-Gm-Message-State: AOJu0Ywyop2UsSY0cSR409bNq1+PCKHZvx3ppxoj6hNDrYHWmRFw6Unz
	AOgk0VY7rq7fn0DAI7ptg2dEpyKv/HEaj7pFYFEG8O1XxV449udVyeMcKKnTGK1KQZLQS4P7qV1
	exOR5ZVQoreGWZgPcgIS55bCkC1LgMHw3C9Nu3O7/h8tkwGBLF7KAoO8=
X-Gm-Gg: Acq92OHhm/yETnVqYHrgIE8ScjRCtSQXXY0FbFE+JwJlRREMc4jQsYD+C1QNnkSEhMg
	LfP+YAA7V1mT1tms4N47mELdqLhwOQ7hb6/kMSsBRCm+vBrntwM6bdcmBMn5Yh8bkNPDzvCw7HT
	hIPYwuOXFgzBqRZPuqI7bxl6DsfAQRRjn7HqfHV6cQOo8eHotylrHzSmcKIL8l7Q4H1qc0HtEqz
	E7rD0h1XCAVlGwBRlWFZ8GsiYJQmz/9rswG/EfygMvIhem9AV8VpRIHGEQHSiNASU+JdFIeH3Va
	0kyIVhmaf8e+bhLjUoxEpxP4Dpfi85gTRQt5as3bQMO2TKD8
X-Received: by 2002:a0c:fb43:0:b0:8cc:f3e0:87fd with SMTP id
 6a1803df08f44-8cee5f9f83dmr297340816d6.8.1781097023425; Wed, 10 Jun 2026
 06:10:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKv6aAM8_EWgXScnKmKYm_4SwGDVBK++dzfP+Y6msUXbp99QUw@mail.gmail.com>
 <18972686-936d-4fb0-850f-7e212c48ab97@ovn.org>
In-Reply-To: <18972686-936d-4fb0-850f-7e212c48ab97@ovn.org>
From: Johan Thomsen <write@ownrisk.dk>
Date: Wed, 10 Jun 2026 15:10:12 +0200
X-Gm-Features: AVVi8Ccp_06BgJAKDooqyTG9fYqL1BcRnGWGV3YUI8gE4NE5slL-gOTtE8rqtZk
Message-ID: <CAKv6aAPoo98bZ-oRk34huUtD3=j7EuGcL2sOLBB_rwzf4vpj3A@mail.gmail.com>
Subject: Re: [BUG] FORTIFY: memcpy overflow in skb_tunnel_info_unclone() from geneve_xmit()
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ownrisk-dk.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:i.maximets@ovn.org,m:netdev@vger.kernel.org,m:dev@openvswitch.org,m:kees@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[ownrisk.dk];
	FORGED_SENDER(0.00)[write@ownrisk.dk,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297678-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[write@ownrisk.dk,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[ownrisk-dk.20251104.gappssmtp.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,ovn.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 585686699B3

Hi Ilya,

Sorry for the late follow-up.
Your patch has now run without crashes in my setup for 36 hours and
I'm unable to re-trigger a panic.

> But the operation in the diff above is kind of pointless as the memcpy
> itself will copy the value again.

Right. So it would probably need at least a comment, if that ends up
becoming the final fix.
I'm not a kernel dev and I don't know what is the right thing to do here.

Happy to test alternative patches if needed.

BR
Johan

Den man. 8. jun. 2026 kl. 11.41 skrev Ilya Maximets <i.maximets@ovn.org>:
>
> On 6/8/26 10:25 AM, Johan Thomsen wrote:
> > Hello,
> >
> > I am seeing what looks like a kernel bug in the Geneve/OVS/vhost
> > transmit path on a Talos Linux node running Kube-ovn with Geneve
> > overlay and KubeVirt VM traffic.
> >
> > Environment:
> >
> > Kernel: 6.18.33-talos
> > Distro: Talos v1.13.3
> >
> > Compiler/config:
> >
> > CONFIG_CC_VERSION_TEXT="clang version 22.1.2"
> > CONFIG_CC_IS_CLANG=y
> > CONFIG_LTO=y
> > CONFIG_LTO_CLANG=y
> > CONFIG_LTO_CLANG_THIN=y
> > CONFIG_FORTIFY_SOURCE=y
> >
> > Hardware: HPE ProLiant DL325 Gen11, AMD EPYC
> >
> > NIC driver: bnxt_en
> >
> > Workload/network:
> >
> > Kube-OVN, Geneve overlay
> > Open vSwitch datapath
> > KubeVirt/QEMU VM traffic via vhost/tap
> >
> > Relevant console output:
> >
> > [  648.742603] memcpy: detected buffer overflow: 104 byte write of
> > buffer size 96
> > [  648.749907] WARNING: CPU: 61 PID: 27020 at
> > lib/string_helpers.c:1036 __fortify_report+0x45/0x60
> > [  648.758689] Modules linked in: dm_round_robin dm_multipath lpfc
> > nvmet_fc nvmet intel_rapl_msr intel_rapl_common ahci nvme_auth bnxt_en
> > nvme hpilo hkdf libahci sp5100_tco watchdog k10temp
> > [  648.775429] CPU: 61 UID: 107 PID: 27020 Comm: vhost-27002 Not
> > tainted 6.18.29-talos #1 PREEMPT(none)
> > [  648.784735] Hardware name: HPE ProLiant DL325 Gen11/ProLiant DL325
> > Gen11, BIOS 2.84 11/05/2025
> > [  648.890478]  skb_tunnel_info_unclone+0x179/0x190
> > [  648.895152]  geneve_xmit+0x7fe/0xe00
> > [  648.907240]  dev_hard_start_xmit+0xa7/0x1f0
> > [  648.911479]  __dev_queue_xmit+0x864/0xf40
> > [  648.919688]  do_execute_actions+0x9b9/0x1be0
> > [  648.927727]  ovs_execute_actions+0x58/0x170
> > [  648.931960]  ovs_dp_process_packet+0xb1/0x1c0
> > [  648.936370]  ovs_vport_receive+0x90/0x100
> > [  648.940428]  netdev_frame_hook+0x146/0x1a0
> > [  648.954093]  __netif_receive_skb+0x3f/0x160
> > [  648.958324]  process_backlog+0x10c/0x210
> > [  648.962295]  __napi_poll+0x2f/0x190
> > [  648.965832]  net_rx_action+0x2e3/0x500
> > [  648.969632]  handle_softirqs+0xe7/0x310
> > [  648.985387]  tun_get_user+0x137e/0x1510
> > [  649.005878]  handle_tx+0x41f/0xd30
> > [  649.029014]  vhost_run_work_list+0x52/0x90
> > [  649.033162]  vhost_task_fn+0xc2/0x140
> > [  649.064145] ---[ end trace 0000000000000000 ]---
> > [  649.068820] ------------[ cut here ]------------
> > [  649.073489] kernel BUG at lib/string_helpers.c:1043!
> >
> > I don't know whether this is a real overflow or a FORTIFY false-positive.
>
> Looks like a false-positive from the __counted_by fortification.
>
> I'd guess something like this would fit it:
>
> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
> index 1fc2fb03ce3f9..e51c3795da474 100644
> --- a/include/net/dst_metadata.h
> +++ b/include/net/dst_metadata.h
> @@ -164,6 +164,7 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
>         if (!new_md)
>                 return ERR_PTR(-ENOMEM);
>
> +       new_md->u.tun_info.options_len = md_size;
>         memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
>                sizeof(struct ip_tunnel_info) + md_size);
>  #ifdef CONFIG_DST_CACHE
> ---
>
> Johan, could you try this in your setup?
>
> The memory was actually allocated for the options, but the structure
> is zeroed out on allocation, so the __counted_by check doesn't work
> properly for the initial initialization copy.
>
> But the operation in the diff above is kind of pointless as the memcpy
> itself will copy the value again.  So, I'm not sure if that's the right
> solution here.
>
> Alternative might be to revert the kmalloc_flex back to the simple
> kmalloc in metadata_dst_alloc.
>
> CC: Kees
>
> Best regards, Ilya Maximets.
>
> >
> > I cannot reproduce the issue on Talos v1.12.X which uses a gcc built
> > kernel, whereas the affected kernel is built with clang. Don't know
> > whether this is relevant here.
> >
> > I am currently trying to make a reliable reproducer, but I can almost
> > always trigger the issue when iperf stressing the VM-network.
> >
> > Please let me know if this should go to a more specific
> > maintainer/list or further info is needed. I am able to test candidate
> > patches if provided.
> >
> > Downstream bug reports:
> > https://github.com/siderolabs/talos/issues/13440
> > https://github.com/kubeovn/kube-ovn/issues/6767
> >
> > Thanks,
> > Johan
>

