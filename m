Return-Path: <netdev+bounces-258569-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5SsFIQvKjmmlEwEAu9opvQ
	(envelope-from <netdev+bounces-258569-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 07:51:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E5B1334E9
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 07:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B417300D76D
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 06:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E587C26A1A7;
	Fri, 13 Feb 2026 06:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TaUQK2c/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53AB217659
	for <netdev@vger.kernel.org>; Fri, 13 Feb 2026 06:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770965510; cv=none; b=ME8aDd4fZokI9CTslMLSKZXYGwTpkgkYiqq4fnzFnq0AT2FNZxiNflATfYFAIyenMJ4ZJus3ZQNDh92qQ4xnWVIOmoMv3vQv0yvgG78VALxJyXWHyKITV/vGyC/dCDGJwi31kitb4RplI+vC9DLSIdih0JLOO4XAArWvGbeYkkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770965510; c=relaxed/simple;
	bh=vJz1YZIsrkWRgT3a+32wzuiXm4tMPz5zEmaZG9RxIA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfcClQQpwIrq6ecMpNrZ43aGxTYyss+xhygwVwscB6+Iv0LL8IJNYE2FyTsi3cFF0zoUi9xs1VKHAkQIfTkBsms4DzbzTxL0leOWtMa3Ks02xUe8astVA1Fwm68v0C8INZaiJpNqsklwVkkYDev8iSIw1uwyq/xt/t9e7AHXpW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TaUQK2c/; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-124a1b4dd40so1586873c88.0
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 22:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770965509; x=1771570309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WFllcNF1m/veazpXfhkGge2XTmCfSEav8feNbAw2Nvs=;
        b=TaUQK2c/6f/d8F3IP8QSC4LPCJ1C8PEWYtgYh8dCaMjW7m8iD1j2/nhbyhhS8bXmK2
         Q1H3csHZvWitcfc468VsmNTSc9JHWVnZR3rOtziVIwKnxQAJcxhfz/fwOassqK4Xrm9M
         H2c3ZwPvRVIW/+teqfmiJ00LQ31ME8ax/bNqM7ndPbiAEUwNzSw8ZzNRY5uIsJZKsn4F
         0LswqFcOfequ4Kd+cNGis+a9AyypkVPTrG3RE1HiO4NnzvoOI8R1yMUim7ZNUldWep9r
         Br9YuTpq8dvWW44fF+aKjSJxzvUJDngBX5kMJFWm3AKZiOIXfBxG5YRLNzmbl/cBtLcW
         V8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770965509; x=1771570309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFllcNF1m/veazpXfhkGge2XTmCfSEav8feNbAw2Nvs=;
        b=N9r9i52Ljs7RHC0vuPKaLl9doaaG7YDc+pXcfodIQMs1pTHq9mnHoIjTAY0GosDKNx
         2ilKccfsSyrY/qZ5ECnwjvwtPip2KDAoC5bHRmNK6N6cKh5nfRjgzCVBdpjI1ZKlkcGt
         zy93zk8S53KOAjvDBG+EGb/NlkDLzznMkIWzVpUxymLR+ok7n74+XD8W0rd3o5IBs0uS
         hPdQLT5Vfu1T6HcvcscZ3Pdqdek15J+gXwLpEh2Qqyhza3scObp3N/bwTG35DrRUsKpN
         XdCyaKpd4rCkjNB//2tnznHcF9kuMLMTgdl0gmaUuCKvPM5+7PRF4EFuzaL8vTbZhKlf
         oyQw==
X-Forwarded-Encrypted: i=1; AJvYcCXEKQUwo2ZmRRKzI2bHms2VLRAIT5MVEli3+knKdUc1kci2s/rw+iiY2m67fZeFkP1N38vqG1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHW1dlXp83MNhYD+vbvBDzZcwFgRSQ51CVcisV0/TAKzrHnSUs
	3tgp9wqr1sdOjjfFzXqhSHukGv2C8xcd9LqAWtCRmvoxuaVZ0Rf3dgJd3t5Gu8c=
X-Gm-Gg: AZuq6aJd0ui3efGbjW5V5v0fKDzrgb/jevE7eAcQTJPsxmINl+ZXIMEYU4BTBMryKPa
	788diC1WlGzgYleCmKuJaQSb3zdt15UQy1zKEAajeExGO0BeIcGiKipsvTbUBDFGJeHUOWX43s+
	lEXpzwtlRfP6sCZEce1awOk0jEguFo7Qr2/gjLbyfu68jrz22fshU7aNcq+dccWh6GkO6dstDbn
	wAVIwyrIRFCS3k8vkFHoyNrPdHnVN8hlVysaeN/vIdDzmXrvRHFUKWU0RYqEdEFxmIrWyBw+rk7
	7yA3OsDVo/khyYWXCbM1Dy/kHqtbbPbVK7HskiWXEW/3o8ZLe7f2itwRtZcTTtLNrVRZkecWVPP
	tBjrq+fzSkFdfCMCD07OtPni/6rB5OpjonDetJZzhap+dWbZRgEt9QKqKlriyG1sZKIRHzMhoui
	lt1PM2yY3D+bK5kikwLgEgGDcuMVnbGpoKRevVdxKCwtCgGAkMbj6u9sddJAgLRIlWYg882S4MA
	6aX+oEuHBX400jmLg==
X-Received: by 2002:a05:7301:2f99:b0:2ba:7033:533b with SMTP id 5a478bee46e88-2babc47ff16mr240332eec.32.1770959815327;
        Thu, 12 Feb 2026 21:16:55 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dbe123asm5764986eec.13.2026.02.12.21.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 21:16:54 -0800 (PST)
Date: Thu, 12 Feb 2026 21:16:54 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC bpf-next v2 1/5] netlink: specs: Add XDP RX checksum
 capability to XDP metadata specs
Message-ID: <aY6zxmRcBSt4ju86@mini-arch>
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
 <20250925-bpf-xdp-meta-rxcksum-v2-1-6b3fe987ce91@kernel.org>
 <aNYUqdaIJV1cvFCb@mini-arch>
 <e03d6d69-73ea-46dc-b632-149ef5831f85@kernel.org>
 <aNcZdfCivLR2slFw@mini-arch>
 <aYtqKfv0F0l2-hgy@lore-desk>
 <aY0zd4Esewxa-8hw@mini-arch>
 <aY4FB_Gf31V-VYiF@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aY4FB_Gf31V-VYiF@lore-desk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258569-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,gmail.com,davemloft.net,google.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev,vger.kernel.org,lists.osuosl.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 18E5B1334E9
X-Rspamd-Action: no action

On 02/12, Lorenzo Bianconi wrote:
> > On 02/10, Lorenzo Bianconi wrote:
> > > > On 09/26, Jesper Dangaard Brouer wrote:
> > > > > 
> > > > > 
> > > > > On 26/09/2025 06.20, Stanislav Fomichev wrote:
> > > > > > On 09/25, Lorenzo Bianconi wrote:
> > > > > > > Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> > > > > > > checksum will be use by devices capable of exposing receive checksum
> > > > > > > result via bpf_xdp_metadata_rx_checksum().
> > > > > > > Moreover, introduce xmo_rx_checksum netdev callback in order allow the
> > > > > > > eBPF program bounded to the device to retrieve the RX checksum result
> > > > > > > computed by the hw NIC.
> > > > > > > 
> > > > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > > > ---
> > > > > > >   Documentation/netlink/specs/netdev.yaml |  5 +++++
> > > > > > >   include/net/xdp.h                       | 14 ++++++++++++++
> > > > > > >   net/core/xdp.c                          | 29 +++++++++++++++++++++++++++++
> > > > > > >   3 files changed, 48 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > > > > > > index e00d3fa1c152d7165e9485d6d383a2cc9cef7cfd..00699bf4a7fdb67c6b9ee3548098b0c933fd39a4 100644
> > > > > > > --- a/Documentation/netlink/specs/netdev.yaml
> > > > > > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > > > > > @@ -61,6 +61,11 @@ definitions:
> > > > > > >           doc: |
> > > > > > >             Device is capable of exposing receive packet VLAN tag via
> > > > > > >             bpf_xdp_metadata_rx_vlan_tag().
> > > > > > > +      -
> > > > > > > +        name: checksum
> > > > > > > +        doc: |
> > > > > > > +          Device is capable of exposing receive checksum result via
> > > > > > > +          bpf_xdp_metadata_rx_checksum().
> > > > > > >     -
> > > > > > >       type: flags
> > > > > > >       name: xsk-flags
> > > > > > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > > > > > index aa742f413c358575396530879af4570dc3fc18de..9ab9ac10ae2074b70618a9d4f32544d8b9a30b63 100644
> > > > > > > --- a/include/net/xdp.h
> > > > > > > +++ b/include/net/xdp.h
> > > > > > > @@ -586,6 +586,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
> > > > > > >   			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
> > > > > > >   			   bpf_xdp_metadata_rx_vlan_tag, \
> > > > > > >   			   xmo_rx_vlan_tag) \
> > > > > > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
> > > > > > > +			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
> > > > > > > +			   bpf_xdp_metadata_rx_checksum, \
> > > > > > > +			   xmo_rx_checksum)
> > > > > > >   enum xdp_rx_metadata {
> > > > > > >   #define XDP_METADATA_KFUNC(name, _, __, ___) name,
> > > > > > > @@ -643,12 +647,22 @@ enum xdp_rss_hash_type {
> > > > > > >   	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
> > > > > > >   };
> > > > > > > +enum xdp_checksum {
> > > > > > > +	XDP_CHECKSUM_NONE		= CHECKSUM_NONE,
> > > > > > > +	XDP_CHECKSUM_UNNECESSARY	= CHECKSUM_UNNECESSARY,
> > > > > > > +	XDP_CHECKSUM_COMPLETE		= CHECKSUM_COMPLETE,
> > > > > > > +	XDP_CHECKSUM_PARTIAL		= CHECKSUM_PARTIAL,
> > > > > > > +};
> > > > > > 
> > > > > > Btw, might be worth mentioning, awhile ago we had settled on a smaller set of
> > > > > > exposed types:
> > > > > > 
> > > > > > https://lore.kernel.org/netdev/20230811161509.19722-13-larysa.zaremba@intel.com/
> > > > > > 
> > > > > > Maybe go through the previous postings and check if the arguments are
> > > > > > still relevant? (or explain why we want more checksum now)
> > > > > 
> > > > > IHMO the linked proposal reduced the types too much.
> > > > 
> > > > IIRC, PARTIAL was removed because it's mostly (or only) a TX feature?
> > > > So no real need to expose it as an rx hint. And I think empty xdp_csum_status
> > > > in that proposal might have indicated NONE?
> > > 
> > > Sorry for the (very) late reply. According to [0] CHECKSUM_PARTIAL can be used
> > > even on Rx side, right?
> > 
> > So is this for virtio (which I don't think you need)? Or something else?
> 
> I forgot to mention before CHECKSUM_PARTIAL is used for the veth use-case
> when the packet is coming from the networking stack.

But what do you do with that partial state in BPF? I doubt you're
calculating/verifying it? Can we treat/export it as NONE/UNNECESSARY for now?

