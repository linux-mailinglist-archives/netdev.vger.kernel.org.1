Return-Path: <netdev+bounces-284736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMZwOM3y+ml1UgMAu9opvQ
	(envelope-from <netdev+bounces-284736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:50:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8495F4D7740
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 09:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5ECD23015D20
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 07:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC85C3DEAC8;
	Wed,  6 May 2026 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vDG52+4X"
X-Original-To: netdev@vger.kernel.org
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF11A3DE425
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778053818; cv=none; b=bKQ9c9UnPO1tnTDQTajS8zTE+dh1j6yaprJIe6wwpDWbjtmLk1jAaSc55V4wPPjxnex2TiVQ21ygdggpVSpV6G+hjXLeQjanQM5TgxiowlgZhweZggb/Da9kiHiDlWkxhr+/j5JGnTbih4z+PNpcsZMszsXQO/fmZblxTB11dp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778053818; c=relaxed/simple;
	bh=9UM/p2GHgtZBWB2nnNQNwwfL28NkX1oHUPY9hLXT1ko=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=IKwkRnkaskcxrGPoik9CvxPxe3Hl75e7YNv6LKrbUYSDJLP0MTo9EA/CA+pmaUu8mnl6h62giXOjJGdnZ+e3oHzPVkdtqUcrvsSkc5lGpT0i3YCbyr4o9YYrCFbqD1WwYJ+ZgEI88M7hgkLZ1QMwDeRph5WQ9W5Gnvp1vCOtZj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vDG52+4X; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778053805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ana/CQ6l1RKzAuIuECIbRgCSQEcVf8WjaVXov83QFQ=;
	b=vDG52+4XayWfmv3ww7pNrM9yBrqcrjmH+hFzGaSIeJYGQYZyT/BFu3cpdUq23GkZJw2he4
	lwvBvoF3rF/Gc49F2hr0EQAEkABdMcvMk5Aipkg994VWw1OT+2SqKjZxE+Z8Kk6OfhzQ59
	hZKupitGGCh1pz6Fc3S2on58QAVYuxA=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [REGRESSION] aquantia: Sunshine/Moonlight UDP video streaming broken since 5b4015ad833c ("net: aquantia: Remove redundant UDP length adjustment with GSO_PARTIAL")
Date: Wed, 6 May 2026 00:49:49 -0700
Message-Id: <F03BE787-07D1-440C-81FD-F7B4D5F1E0C6@linux.dev>
References: <980382a2-3b8c-4da1-ac9b-efd8c0d2c1be@nvidia.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 regressions@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <980382a2-3b8c-4da1-ac9b-efd8c0d2c1be@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 8495F4D7740
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284736-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.schwartz@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lizardbyte.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nvidia.com:email,linux.dev:dkim,linux.dev:mid]



> On May 5, 2026, at 8:05=E2=80=AFAM, Gal Pressman <gal@nvidia.com> wrote:
>=20
> =EF=BB=BFOn 27/04/2026 21:26, Matthew Schwartz wrote:
>>> On 4/27/26 11:09 AM, Gal Pressman wrote:
>>> Hello Matthew,
>>>=20
>>> On 27/04/2026 2:20, Matthew Schwartz wrote:
>>>> Hello,
>>>>=20
>>>> When using a previously working setup of remote streaming from my works=
tation to another device via Sunshine (the host server) and Moonlight (the c=
lient app) on my home network, I no longer receive any video output on the c=
lient app after upgrading my host workstation to kernel 7.0. Reverting back t=
o kernel 6.19 on the host restored my setup to a working state.
>>>>=20
>>>> After bisecting, I landed on 5b4015ad833c ("net: aquantia: Remove redun=
dant UDP length adjustment with GSO_PARTIAL") as the first bad commit. I con=
firmed this by moving the cable to my second on-board NIC (Intel) on the sam=
e workstation, which restored video output without any other kernel changes.=
 My affected on-board NIC is Aquantia AQC113 [1d6a:04c0] (rev 03), atlantic d=
river, firmware 1.3.34, MTU 1500.
>>>>=20
>>>> Looking into it a bit further, ethtool -K enp97s0 tx-udp-segmentation o=
ff also serves as a workaround on my Aquantia port without changing to my ot=
her ethernet port. The working Intel NIC reports tx-udp-segmentation as "off=
 [fixed]", so traffic falls back to software UDP segmentation on there.
>>>>=20
>>>> Please let me know if there's any additional info I can provide.
>>>>=20
>>>> Thanks,
>>>> Matt
>>>>=20
>>>> #regzbot introduced: 5b4015ad833c
>>>=20
>>> Thank you for the report and the bisect!
>>>=20
>>> I will take a look and try to figure out what's wrong (though I don't
>>> have real hardware to test on).
>>> Is the userspace app open source? can I see its code and try to run it
>>> myself?
>>=20
>> Thanks for the reply. The code for Sunshine is available here: https://gi=
thub.com/LizardByte/Sunshine and the code for Moonlight is here: https://git=
hub.com/moonlight-stream/moonlight-qt.
>>=20
>> I have been using the Arch Linux Sunshine package which I installed by fo=
llowing the Linux instructions here: https://docs.lizardbyte.dev/projects/su=
nshine/latest/md_docs_2getting__started.html, but there are also binaries fo=
r other distros or it's buildable from source. For Moonlight, I have been us=
ing the Flatpak distributed on Flathub because the client device runs an ato=
mic rootfs, but you can also use any other device that Moonlight supports.
>>=20
>>>=20
>>> I will be OOO for the rest of the week, hope to have some meaningful
>>> reply by the end of next week.
>>=20
>=20
> I think I see the issue, do you mind testing the following diff?

Sorry for the delay. I applied this diff and I=E2=80=99m able to stream from=
 my host to clients again without any issues.

If you send this version upstream, feel free to add my Tested-by to it.

Thanks,
Matt

>=20
> index a0813d425b71..5bd1706b11b0 100644
> --- a/net/ipv4/udp_offload.c
> +++ b/net/ipv4/udp_offload.c
> @@ -599,10 +599,22 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gs=
o_skb,
>        uh =3D udp_hdr(seg);
>    }
>=20
> -    /* last packet can be partial gso_size, account for that in checksum *=
/
> -    newlen =3D htons(skb_tail_pointer(seg) - skb_transport_header(seg) +
> -               seg->data_len);
> -    check =3D csum16_add(csum16_sub(uh->check, uh->len), newlen);
> +    if (skb_is_gso(seg)) {
> +        newlen =3D msslen;
> +    } else {
> +        /* last packet can be partial gso_size, account for that in
> +         * checksum.
> +         */
> +        newlen =3D htons(skb_tail_pointer(seg) -
> +                   skb_transport_header(seg) + seg->data_len);
> +        check =3D csum16_add(csum16_sub(uh->check, uh->len), newlen);
> +    }
>=20
>    uh->len =3D newlen;
>    uh->check =3D check;

