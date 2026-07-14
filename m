Return-Path: <netdev+bounces-307376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TC7NIRfoVWqqvQAAu9opvQ
	(envelope-from <netdev+bounces-307376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:41:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D1B752008
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 09:41:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linaro.org header.s=google header.b=PQjSbYhG;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307376-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307376-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linaro.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F57630434EB
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 07:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9947C3EEAE9;
	Tue, 14 Jul 2026 07:35:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE33ED5C9
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 07:35:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784014552; cv=none; b=mByOWjadh+RuuST6omCcoBTDriuHioQc8FWPJPVQKt2+lTPF2NTgUXjfP0Y9mmgRoe14UPnPrjRbv6v0wozQQzDm0vpbe8V6Cr7WQgpnUSAK2cIHLxnubGBeh3wzbWpnaa2H3q11kMDhOs5FKE7728beklQMoGFfbqqegoV5FHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784014552; c=relaxed/simple;
	bh=thE6MKDBgxQ/2kTxtQxylJzWWa2DTPV9HWq/Oqshg8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNTFMRR9e6UqHBq1tE4/8/PnOvb7vNhlDwyUndu3LhdRzmCtL+CqxQctkFCbmkxaUndKpKg1c9QpEHn/AXiPISjSxPYp1LkthOdOteNcCWYuCJ4sZIVZiA/fwKaBWJKefS5eoEXBKIXyZIYy+f+ZHtEbzhIvgynargps8f2+WuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PQjSbYhG; arc=none smtp.client-ip=209.85.221.48
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4720d22c94aso594843f8f.1
        for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 00:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784014549; x=1784619349; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EZDP77brQ5bvhb37m4sjMTk+Xtc5WyoVuJCcZEy5/Us=;
        b=PQjSbYhG7l9ASUYQmKlYFS+sKvO+M8bmtQiQpO9+yci4idNJeTkjbL0liIGnl2qYXn
         4YwVv3dN31nMt73EBvIVlJaIKZrBvjRJabefKFt0zaxRhJl8lokR4kW3bl/I2s5E4PvT
         q1QHKu7/4S1FuN+Y+hrRgOhQBCThOZwpqAgTV4omkYPO1e7VcnmhoV+b5STXEEe1r5JD
         d2Bqk6T0LHKEqMVA4FWw8NzyVrUhNfycHspKydsrGqcJg6jesH7fzT3sJMZWcOGP+ZUy
         BUXuj/2K7xFFBLBSHv8pg7qWtHmhXty2UH8Rr5vRZNuN/t0mIlCDBpsa+hcTk90njqgk
         B31Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784014549; x=1784619349;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EZDP77brQ5bvhb37m4sjMTk+Xtc5WyoVuJCcZEy5/Us=;
        b=PBdiNa6uDN0T+42PPRS1OoI8qa+E8mD/jVGg+iOIRCNRlPVaVYvkYH5uW8Jkjk1Jgg
         aINGh0/wUCL6/qVz8wERNSSpJ6OPJyokMn96Vtn/EXmTRYux6LJaXjc6h9L+UxS73dFO
         18bEN3DgoQh5Dl/archIROpFbtsETrqnB+gBxXgMDpiYjgEWdNCFAYAmkXvz0QwF1teg
         ac4upk84TIIUvFZD+bJcPCeOOiO7v/CVjAXs2oGMa5YysVeu9Km3XLICe80HmS6rAgod
         d9xlL9cZED/GOl5XZC0Apheexiq2DDxkpzFms/4zRuculhPx0T07ZDwThMR3w6c8pxdL
         2NYg==
X-Forwarded-Encrypted: i=1; AHgh+RpI1tneFMmxtL96lqFNe86pvdFbtnEiA/eZqMgKtmFsdhaE4qI4RyB82CDYBrqwVrg8r2214n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM9YQitB+4aYGHm68TF/y2uiqakEK2mj1F4uezY3CwZs2wI3Fr
	FYVXhhw66+4GGYcdkNy+cfrGBTwv5OKzHbK4QtwjrybhILH13CLWbvrkhMe2BJn8JLQ=
X-Gm-Gg: AfdE7ckG4rhtsk4EG9oRmG0EYizOYqySkxPbKkzEn6RIBDEHAyoDCrqC0vNZsMbYNNj
	2XWXP1BxYJ5tSyOrr1P+EWcV/oNUmFp80dcPP+DZv58kTmp+cSk2X8W8/swLutRqSgscbCrFll2
	SiaWd6NcvFyPtVixseRqNBVJ0wCaBPy/0OTjrfvsGC8yIlJgKAGw+Roow37pxW/QE6XLxLEjudZ
	TmArDOM9IS2KiihgU/sDE1EUA8lg/t3V3tdn7W0MqxGH1RGv4FNfcwT6VB1a649DnCpdEkSLY0K
	3lFpW9wC88t5BzebBvIrickiTy56v0NGU4eDsx2xMVNNsr6l/UDq7a/WaC/X/uLj52gOHhR+114
	Qea8+CitMbG87Rv/9m2ztKv35tEwmJbmdmMNTE6cJZlMrwsSYhsFUBJ6Hp9hIMneCgu0QFLhxtF
	9k+W2xix/35rGKs41hJanRYfMi
X-Received: by 2002:a05:6000:2404:b0:473:673e:3836 with SMTP id ffacd0b85a97d-47f2dcf8a3amr14217779f8f.28.1784014549221;
        Tue, 14 Jul 2026 00:35:49 -0700 (PDT)
Received: from linaro.org ([2a02:2454:ff24:7210:6c30:6cbd:7b12:2745])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464caeffsm5599960f8f.36.2026.07.14.00.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 00:35:48 -0700 (PDT)
Date: Tue, 14 Jul 2026 09:35:46 +0200
From: Stephan Gerhold <stephan.gerhold@linaro.org>
To: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>
Cc: Stephan Gerhold <stephan@gerhold.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	chris.lew@oss.qualcomm.com,
	Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] net: wwan: qcom_bam_dmux: Alloc RX buffers as a
 single coherent block
Message-ID: <alXm0rp3NK62G3-3@linaro.org>
References: <20260714-qcom-bam-dmux-vmid-ext-v1-0-3f29da7cca76@oss.qualcomm.com>
 <20260714-qcom-bam-dmux-vmid-ext-v1-2-3f29da7cca76@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-qcom-bam-dmux-vmid-ext-v1-2-3f29da7cca76@oss.qualcomm.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gerhold.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,oss.qualcomm.com,gmail.com,sipsolutions.net,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-307376-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vishnu.santhosh@oss.qualcomm.com,m:stephan@gerhold.net,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:loic.poulain@oss.qualcomm.com,m:ryazanov.s.a@gmail.com,m:johannes@sipsolutions.net,m:linux-arm-msm@vger.kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:chris.lew@oss.qualcomm.com,m:deepak.singh@oss.qualcomm.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,m:ryazanovsa@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER(0.00)[stephan.gerhold@linaro.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephan.gerhold@linaro.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linaro.org:from_mime,linaro.org:dkim,linaro.org:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D2D1B752008

On Tue, Jul 14, 2026 at 11:02:32AM +0530, Vishnu Santhosh wrote:
> On Qualcomm SoCs where the modem (e.g. the mDSP on Shikra, VMID 43 /
> NAV) is the AXI master for BAM-DMUX RX transfers and the XPU enforces
> per-region access control, each individually DMA-mapped RX buffer
> requires its own XPU resource group (RG). With ~16 RGs available, the
> 32 per-buffer dma_map_single() calls exhaust the table and the first
> inbound transfer faults with an XPU violation.
> 
> BAM-DMUX is a singleton (exactly one instance per SoC), so the
> destination VMID does not need to be a DT property; it is looked up
> from the compatible string's match data instead. Add struct
> bam_dmux_data with a single vmid field, and a shikra_data instance
> hardcoding QCOM_SCM_VMID_NAV for qcom,shikra-bam-dmux.
> 
> When match data is present, allocate all BAM_DMUX_NUM_SKB RX buffers as
> a single contiguous dma_alloc_coherent() block and SCM-assign that
> block to HLOS plus the VMID once at probe. This reduces RG consumption
> from 32 to 1. The block is never reclaimed across a modem power cycle
> (bam_dmux_power_off() does not touch it), so the probe-time assignment
> covers every subsequent restart without re-assigning or reclaiming. It
> is reclaimed to HLOS only once, at remove or on a probe error, and if
> that reclaim fails it is leaked rather than returned to the page
> allocator.
> 
> Each rx_skbs[] slot is pre-assigned its virtual and DMA address from
> the block, so no per-buffer mapping is needed at power-on. Because the
> coherent block is not page-backed, received payload is copied into a
> regular netdev skb before handoff to the network stack; this is an
> unavoidable extra copy on the XPU-enforced RX path.
> 
> Platforms without match data are unaffected: rx_virt stays NULL, no
> coherent memory is allocated, and the per-buffer dma_map_single() path
> is unchanged.
> 
> Co-developed-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> Signed-off-by: Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>
> Signed-off-by: Vishnu Santhosh <vishnu.santhosh@oss.qualcomm.com>

So how do you handle TX buffers? Right now, they are just passed on from
the net subsystem. There can be up to 32 TX buffers in progress as well.

Overall, I have mixed feelings about this patch. It looks reasonably
simple, but fundamentally I don't understand why we need to go back to
the old days of implementing protection using a highly limited MPU (in
your case: the xPU).

Why does the setup of BAM-DMUX differ e.g. from the setup for the crypto
engine? Crypto is also using bam-dma, but it avoids this inflexibility
by making use of the &apps_smmu. Is BAM-DMUX not covered by the SMMU? Or
did you just decide to bypass the SMMU in this case? (If so: Why?)

If you had BAM-DMUX mapped using the SMMU you would get all of this for
free. No changes would be needed in the BAM-DMUX driver ...

Thanks,
Stephan

