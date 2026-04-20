Return-Path: <netdev+bounces-279870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAxRFEBV5mkDuwEAu9opvQ
	(envelope-from <netdev+bounces-279870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:33:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D08EB42F9AC
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:33:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5ED79302C55F
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 16:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980AA34C121;
	Mon, 20 Apr 2026 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sE1n2UzV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com [209.85.161.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68965346781
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776702431; cv=none; b=UGUL94TDoDWb/7qngx+4SChrYZMpyt6r8b6BAM/6rRrwSQWrHnn30S2MDxN3jCtG+Vwf/DNJeEX5PqPwp3w1ZSAv9RKaQH19a6+hkxBMuz8ezU16gnEz/R8f9F0MxRqTAujRhsRPSWvWL9/FWOT+9nxOvBdfKftU5m4pb9AS8J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776702431; c=relaxed/simple;
	bh=dY4fqKECo7eqADZphbJATvq9E4FnAFlZU510YDrjeE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hx+qnJo0SItTI3WJCeoVHgdqwAIoPYpdrYkMU1c8ncRIIHbnfNqkS4UJZrXydlr3gTWARQE1sOFbFU6z3J0l3pI9vePjWzpBHY2IXSLgkhLX1k7Y1ptgeMsIJq3e4jEamm5U5x4/xQ5XSnxw7XSWadTBjKuVDtnbZYDzcrLc4q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sE1n2UzV; arc=none smtp.client-ip=209.85.161.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f67.google.com with SMTP id 006d021491bc7-67c250805ccso1003462eaf.1
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 09:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776702428; x=1777307228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx+Z1b8A20YiWzWJo1QqCE8ssM1GtNYptzqBgdgASec=;
        b=sE1n2UzV4f1t/MddfTc8ZVAtW4sVbeXbdJuYBQLhafPzquSAALqD1ITPLEQgTCPX0Y
         31wFYAeQ5WLnZ+zStrs8KFhRDHXRNzwdb1CyXPNPWxtHI0Zfw6f2Wk0SKuk6NgdFdt/n
         r7Y4IT8joLxE63ZmH16QRcjvEzSbyjKcYA2qNkFeWs/rcU7I/AWow8B9SmpEB3r6sqK4
         lpJ6n68ANOtTjLiP9azLXA3LnHtHTItF+Pdm8c9Esy6h7ZFUn8FU08S/R1RSIu3zZnRk
         4IgooCyU0kSm/Midl7PiQfU5Xzye1uNnmRyQnKa90qAs2wgeIYmWoi7W/oc+jxOrHXQ4
         4nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776702428; x=1777307228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cx+Z1b8A20YiWzWJo1QqCE8ssM1GtNYptzqBgdgASec=;
        b=NXIqi0S7Zl1B9hDTH6b6WEUkyInxkxNLB55xOKxo8bWX06oimlpUgXVI4vH56i+u+S
         cqzZPSRJK2pb3z7wa0vDojX+IJHXwOBVU66WOl2X5ORMrYsR+ZBv9GiVsQnn/mH9LuzX
         aRuNmxAmHu+iWi25NwmDSzPAv05+5CJOymQz7/dud72mbc8/63OuO/bJrIwz16iDRqSF
         wE05vTFwJO7I0Si0D5zCE7ikkZymqtJToK0the4Q4s9ypVO7v+XwQwS7IdztndDL/zyN
         YHyOajzaX9nBP+wLXQ12Kd7ISBEpcE3HGfOLiTj5OONZU3dpVA5R1RwsYuDLcnX6UCbO
         9K6w==
X-Forwarded-Encrypted: i=1; AFNElJ+x75WBaLCoL/qpYQdZP+FLeXhCsXirpaihIL4WEkGciNYqDEc/4jtPMbapyi+N/MaPvIsisAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ/13Mf4/4CLUCeoL+0uuUTjmUkXBh1HMkii8UNsYuBhFco1R7
	zvOKANaif5oBIyG1MGoUipNGnsBbvcSs3D2RWq/PwUZpou6/PC+EjUiU
X-Gm-Gg: AeBDietbkJK/WYK6JqdCe/UoME6/GMdXq4s3k5CuuvCMBSFd29paDmGepq0rqnOOBWg
	qOYH1okhhhV3Uf2P53gHEdPLKCxq/GYNSrgeC+dwUeVjtnof8EDlI2E/80dIobKGyAKy1LTSKh+
	kN3nubK2fc1mV00Zi6R80zCjgcmxE2Vwgz06RN4YdbPBGgMhQ2+imrPpEbzWzLLuUg9glOOqPia
	IkEI9fdXqajjBLAWwCftp5WKJPV5/gfZpbGHp04t5hEiIW9RtX1T3F1sPofE0K0b1uJpkPFL0pl
	UW7jq9eLX+cJ0Nnnvpp+k7dnl80Qggp3tVT1fXUvVUgu79p2TRmpBPf0W8dCRRkxzQsp+9U5OBu
	obKsPchI2TS3fcRGRKkn3p8M/JGGYZP/DH8/hn3PsvfgnY+YBZF6lcDsclGXix3lmTiEQ57VWu1
	Pb5ev87aYueUutPqgHf1n7kY1pMmWm
X-Received: by 2002:a05:6820:f021:b0:683:1323:e183 with SMTP id 006d021491bc7-69462ee4226mr7718815eaf.32.1776702428293;
        Mon, 20 Apr 2026 09:27:08 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:41::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69464fe6d3esm6031932eaf.14.2026.04.20.09.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 09:27:07 -0700 (PDT)
Date: Mon, 20 Apr 2026 09:27:05 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 1/4] xsk: avoid skb leak in XDP_TX_METADATA case
Message-ID: <aeZTxgvr0mdIG-lK@devvm17672.vll0.facebook.com>
References: <20260418045644.28612-1-kerneljasonxing@gmail.com>
 <20260418045644.28612-2-kerneljasonxing@gmail.com>
 <aeZEjZSsVIdpcbFF@devvm17672.vll0.facebook.com>
 <aeZI3ig6w0PhGaVU@devvm17672.vll0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeZI3ig6w0PhGaVU@devvm17672.vll0.facebook.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279870-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fomichev.me:email]
X-Rspamd-Queue-Id: D08EB42F9AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/20, Stanislav Fomichev wrote:
> On 04/20, Stanislav Fomichev wrote:
> > On 04/18, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > > 
> > > Fix it by explicitly adding kfree_skb() before returning back to its
> > > caller.
> > > 
> > > How to reproduce it in virtio_net:
> > > 1. the current skb is the first one (which means no frag and xs->skb is
> > >    NULL) and users enable metadata feature.
> > > 2. xsk_skb_metadata() returns a error code.
> > > 3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'.
> > > 4. there is no chance to free this skb anymore.
> > > 
> > > Closes: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kernel.org/
> > > Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > 
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Actually, I take that back.. While looking at patch 2 (which always
> confuses me with that -EOVERFLOW handling), looks like we set
> skb->destructor in xsk_skb_init_misc? So this kfree will do
> xsk_cq_submit_addr_locked? Not sure that's what we want? Should we
> move xsk_skb_init_misc to happen after xsk_skb_metadata?

Ooops, looks like you already addressed these in v2? Let me look into
that..

