Return-Path: <netdev+bounces-258401-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cABOBRlRjWnW0wAAu9opvQ
	(envelope-from <netdev+bounces-258401-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 05:03:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6789D12A44F
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 05:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E496131CA8B9
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 03:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFBB2571A5;
	Thu, 12 Feb 2026 03:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fT4fSodR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66920254849
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 03:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770868680; cv=none; b=byXuQ19wnQqORECQvznKlR13BqEbUFit6Gj7xfhJKyOgg9KhxxBjFu4NjQ+4WcK31szIWcN554XIpEXyXQ+1o/4trQSnEt7PzLiu0yM6+Jwn9RAcCdOJk/4I9Axr5m4FWL9Vl1u/O++PXDJDVoBg8yw0Bs5L6dZG76k0FHcazKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770868680; c=relaxed/simple;
	bh=3/pFoT7VwY4XYxl8Pm0Zwg7Bm4NUYgI78VGG2y+61YE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FzrT5embybuS+oevs3BiNG570c8+lG3y0XaKw/PU4nVrGpErZ18Hmu9SZLGagXv3IvhvZvEgv9nc/nw4j/SHWKIrWPCwHNmWY2TmlpGiXAo6JezifdIBcx3OXS1P8G3dQk6KJspzUFUkd9NBrxZQiz8ih8CmNJv0/PKE7HljMiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fT4fSodR; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7cfcb46ffc9so1003837a34.0
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 19:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770868678; x=1771473478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tK21a4JoivTAPugf5a0tgKET71snd9+E0xX3YsV0FIM=;
        b=fT4fSodR+DPTpqu8G9DMNqf7q3V5jepN0sX8VjVlMg6AAc0xAviwgZJymzakV6G7O5
         7c754uF+YLaeBOvQ3Bnx+E5IwjKxue2A9Dthz19eaca9MKF4ZTzs+23pYcZgv23+MvqY
         U+tkAembE1KiAWu3+iyx/g1BIhsx3ApYqEbudg/QKKIVHLUgaMirhryAUK2dZ4Tpp4KQ
         A2KIp3fSLpcr9AB9wdaXurpdZ14I6oxcVOlA5RZiGgTsN90+iuUSLOQPoG7AdR9yMa2u
         5aeyFGzAU99z62F5yQS9GkKQj7Vj2jNpXq28Asnmx0OvZwYNpdfzb0Hi24BlW3GnflTG
         //SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770868678; x=1771473478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tK21a4JoivTAPugf5a0tgKET71snd9+E0xX3YsV0FIM=;
        b=IPr6qeUqqUbHKaJTmumwEjitBIJirms+fqrtj5yuDBXd4qzMXt/6lzUDzAv+7N7ICp
         RcCOR/1w7ODYNimK8JvtgX6SMldCHRbPDA2OpreFikX6h9m0FVQK+2+bQhyX/hJDBFGk
         7g+Fb/BE7AhrmLLrNzD39VQWCIoSdNIpTRHJqfHUXdV3m0frK0SmOuWuZZDggT3me74s
         mIGd4X4pGv7u/bTbnfxGiNec+rfayMGzdn3N0SbRpB6FOno4vZinJ93dZSpgVqw2NkkG
         ERglkDVwxV05NMPik671E3PeLFKF1ODSWa7F7Y5wHHNFtSuUvGg1Fc7Jfk/X04l7Rkf6
         pkXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnlMjVlGegMU1xbnvSCiLXV6EGdGP4c+dxdQWyL3dUt2qCzmuzrofeYH4KIdS7cSYdK4EgGnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl6jwbZ8zw7Eh6dq05jnHPuW+A9sA2XngdCdPFJqnAEhXEjiWT
	jXbocI1pAvPtVkx3WvROwFNYskx4viO+pX49f7CQUxydGdZChLTv9r1Hv6pb
X-Gm-Gg: AZuq6aKMAsE4uBG0VUQBtYCX/vt4siNgoQQcKf7U2VpJ7/PnjjYABCiQwXXrhcYBDYo
	1tVIaeEneDL7eXgWn69tzPblVrvWPokGyijmM3i/AfVNQtQN5ApP5uXuA6cfAiivxZIQ3M2PNHw
	HGL1Uw0r+T8pBLBDpoSbw3MA7aON7xDXDVnpFt/UgEv46/9ZdDoft8gOT/5lOJYlZfwmW/a6bfQ
	q+hUkt/5aYhuJVZGHeSaebJFWSE/nXKAUuXtc9HOb5H0A2P7rYvkhGL1vhZHXb4mdUlgVqscCMl
	cog9JphYU4yV/+f0VNQZxPQrA23wPF/oBxuMz9FghTrUmLOyCmIrzjr21COGCskbPS60Wr8wGd9
	GuGrzW4OjlCrNQq8OEdbMhP7OsCu7/TVSA8yQsnDQRuDRTIhdKDTrWzOKnPsjLHRKYjyGMTBAJN
	OIOwyFctRDGjogvM8coqS1i8KEksA6w/d0X2XEnQj+6ppJLn/g2DDlnhx6GI1Nqab0emMHkTPf/
	WrKOBfkTA49ZBtsJg==
X-Received: by 2002:a05:7022:249f:b0:121:d898:edae with SMTP id a92af1059eb24-1272fd99529mr389245c88.24.1770861432625;
        Wed, 11 Feb 2026 17:57:12 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1272a6e943fsm2870384c88.11.2026.02.11.17.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 17:57:12 -0800 (PST)
Date: Wed, 11 Feb 2026 17:57:11 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
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
Message-ID: <aY0zd4Esewxa-8hw@mini-arch>
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
 <20250925-bpf-xdp-meta-rxcksum-v2-1-6b3fe987ce91@kernel.org>
 <aNYUqdaIJV1cvFCb@mini-arch>
 <e03d6d69-73ea-46dc-b632-149ef5831f85@kernel.org>
 <aNcZdfCivLR2slFw@mini-arch>
 <aYtqKfv0F0l2-hgy@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYtqKfv0F0l2-hgy@lore-desk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258401-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,davemloft.net,google.com,redhat.com,iogearbox.net,fomichev.me,lunn.ch,intel.com,linux.dev,vger.kernel.org,lists.osuosl.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6789D12A44F
X-Rspamd-Action: no action

On 02/10, Lorenzo Bianconi wrote:
> > On 09/26, Jesper Dangaard Brouer wrote:
> > > 
> > > 
> > > On 26/09/2025 06.20, Stanislav Fomichev wrote:
> > > > On 09/25, Lorenzo Bianconi wrote:
> > > > > Introduce XDP RX checksum capability to XDP metadata specs. XDP RX
> > > > > checksum will be use by devices capable of exposing receive checksum
> > > > > result via bpf_xdp_metadata_rx_checksum().
> > > > > Moreover, introduce xmo_rx_checksum netdev callback in order allow the
> > > > > eBPF program bounded to the device to retrieve the RX checksum result
> > > > > computed by the hw NIC.
> > > > > 
> > > > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > > > ---
> > > > >   Documentation/netlink/specs/netdev.yaml |  5 +++++
> > > > >   include/net/xdp.h                       | 14 ++++++++++++++
> > > > >   net/core/xdp.c                          | 29 +++++++++++++++++++++++++++++
> > > > >   3 files changed, 48 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > > > > index e00d3fa1c152d7165e9485d6d383a2cc9cef7cfd..00699bf4a7fdb67c6b9ee3548098b0c933fd39a4 100644
> > > > > --- a/Documentation/netlink/specs/netdev.yaml
> > > > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > > > @@ -61,6 +61,11 @@ definitions:
> > > > >           doc: |
> > > > >             Device is capable of exposing receive packet VLAN tag via
> > > > >             bpf_xdp_metadata_rx_vlan_tag().
> > > > > +      -
> > > > > +        name: checksum
> > > > > +        doc: |
> > > > > +          Device is capable of exposing receive checksum result via
> > > > > +          bpf_xdp_metadata_rx_checksum().
> > > > >     -
> > > > >       type: flags
> > > > >       name: xsk-flags
> > > > > diff --git a/include/net/xdp.h b/include/net/xdp.h
> > > > > index aa742f413c358575396530879af4570dc3fc18de..9ab9ac10ae2074b70618a9d4f32544d8b9a30b63 100644
> > > > > --- a/include/net/xdp.h
> > > > > +++ b/include/net/xdp.h
> > > > > @@ -586,6 +586,10 @@ void xdp_attachment_setup(struct xdp_attachment_info *info,
> > > > >   			   NETDEV_XDP_RX_METADATA_VLAN_TAG, \
> > > > >   			   bpf_xdp_metadata_rx_vlan_tag, \
> > > > >   			   xmo_rx_vlan_tag) \
> > > > > +	XDP_METADATA_KFUNC(XDP_METADATA_KFUNC_RX_CHECKSUM, \
> > > > > +			   NETDEV_XDP_RX_METADATA_CHECKSUM, \
> > > > > +			   bpf_xdp_metadata_rx_checksum, \
> > > > > +			   xmo_rx_checksum)
> > > > >   enum xdp_rx_metadata {
> > > > >   #define XDP_METADATA_KFUNC(name, _, __, ___) name,
> > > > > @@ -643,12 +647,22 @@ enum xdp_rss_hash_type {
> > > > >   	XDP_RSS_TYPE_L4_IPV6_SCTP_EX = XDP_RSS_TYPE_L4_IPV6_SCTP | XDP_RSS_L3_DYNHDR,
> > > > >   };
> > > > > +enum xdp_checksum {
> > > > > +	XDP_CHECKSUM_NONE		= CHECKSUM_NONE,
> > > > > +	XDP_CHECKSUM_UNNECESSARY	= CHECKSUM_UNNECESSARY,
> > > > > +	XDP_CHECKSUM_COMPLETE		= CHECKSUM_COMPLETE,
> > > > > +	XDP_CHECKSUM_PARTIAL		= CHECKSUM_PARTIAL,
> > > > > +};
> > > > 
> > > > Btw, might be worth mentioning, awhile ago we had settled on a smaller set of
> > > > exposed types:
> > > > 
> > > > https://lore.kernel.org/netdev/20230811161509.19722-13-larysa.zaremba@intel.com/
> > > > 
> > > > Maybe go through the previous postings and check if the arguments are
> > > > still relevant? (or explain why we want more checksum now)
> > > 
> > > IHMO the linked proposal reduced the types too much.
> > 
> > IIRC, PARTIAL was removed because it's mostly (or only) a TX feature?
> > So no real need to expose it as an rx hint. And I think empty xdp_csum_status
> > in that proposal might have indicated NONE?
> 
> Sorry for the (very) late reply. According to [0] CHECKSUM_PARTIAL can be used
> even on Rx side, right?

So is this for virtio (which I don't think you need)? Or something else?
Can we start with the "easy" cases of UNNECESSARY/COMPLETE/NONE? I'm not even
sure we need to expose the csum_level (start with level=0 and handle
encap if/when there is a real usecase). With kfuncs we should be able to
change/extend the API when needed.

(for PARTIAL, not even sure what the BPF prog is supposed to do with it)

