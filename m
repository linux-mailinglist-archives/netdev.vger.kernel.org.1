Return-Path: <netdev+bounces-278328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2D/2Mgb13WlolgkAu9opvQ
	(envelope-from <netdev+bounces-278328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:04:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC3D3F6E62
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2FC63024478
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 08:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C90538B7C3;
	Tue, 14 Apr 2026 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mo6Qnnmj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AxhfafsM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C0F38C2AE
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 08:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153761; cv=none; b=fD6JWGQFrr+GZb/rE297AIdRkJoVIZwZgdEizfyB6peHnkM2PXe2DR6oJRBKKt+P0gGnDEanjF9IYvcjvnAlyDDeiTmTuq0XDLWhnU2OkMng/Ps5LrnLxiBFB+Z56AFezA52NqlJ0Gyhchw38rRfus2Wi8f7oPv+vQ12t6bffmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153761; c=relaxed/simple;
	bh=rZCA+zaQ6M5iJd2rjJRrrZnbpAOEaBFdMeSHQoNeGw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2E/EjOhnbG6E+Lh19x5Dt3PTDQ8mjdzatut+FRnWec7mtTHLXPsSNc0vzXcjFjJxkh/lYnDK5rm+iN1ITzWvgo3x10NIWBLoJNdYJsrBu1iNvr7M2pq7KC+KAW41NratAB41CZPzfAfmT54Tlauz0To04raZ6Ijb42Cl0CLNZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mo6Qnnmj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AxhfafsM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776153756;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0Zfw5O+OpGTZWtCSJAetrjJ/SPWXO2K80aEA+W4QDQ=;
	b=Mo6Qnnmj6w/rXlQNeIaVryTktns69qPBIhEsncTOTTjt/9SiuchO2ztOMoUIut3cvDO00y
	Mk+wD7AaWUAVjr+ZjCQ92cAdoCIv95lOnXiSV4mZNfgCSbTCZuEe/FkdNzl0G0OG9yK+nx
	+kXPFmUA2H14SxeysxCOAPKq+DysKJE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-GLXB_u3UPxG2yZzEeCRMPw-1; Tue, 14 Apr 2026 04:02:34 -0400
X-MC-Unique: GLXB_u3UPxG2yZzEeCRMPw-1
X-Mimecast-MFC-AGG-ID: GLXB_u3UPxG2yZzEeCRMPw_1776153753
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488d6ebe9cfso31174495e9.2
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 01:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776153753; x=1776758553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0Zfw5O+OpGTZWtCSJAetrjJ/SPWXO2K80aEA+W4QDQ=;
        b=AxhfafsMAStSb86IBz+cNdS691lyJAKAbbSwPqslo6t9NUvsZ8uVF+LSg7n41OddFW
         A4JuigsgsyjhDU+mInmvOn3+DB36Ex4QAJjhPKLmbK1+no8xrW08WB0MpkuBJESzowjj
         hJqE1pcRoC98NI+iAIR/BjHLvaKTLBi2L8jMhusQCZakHIt3yJnDV+WEmAM2Hq4asxFD
         dnwydnNLlwcFXF+psR0DIDMaVwXkfeOOXOCnEVWC3vu6kC7eH9bvJ5xNIwsUg/laZWi7
         993feDyz6Q55gW576VqgnEqGhxhlvSPD89FzELqMX06oEV/30xvQ97Zv+seAVrT/+8Z0
         7dvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776153753; x=1776758553;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0Zfw5O+OpGTZWtCSJAetrjJ/SPWXO2K80aEA+W4QDQ=;
        b=bsI1DtJBzyo8OeOjuc/yu+CxIWYmdYZlx02oAk/wnoZvqIQh+L2aaevX9q4k05WKAz
         M8zK1uFz9zwrGAN8M6NlIW0mDGaaG/hF7RZ2RE7vEXre9rJnoSl2xWVb+Ct9E6Gn6LOU
         zHrYGWG92MjD/VkhUdcGoDDjol5MJ5QRftBCRdzrobWr2ailaAEaSoaS2Ubd9oWpsqja
         RD7MpiqCmrbnTkB2/zjCde1zrAf4s2xy29xKHrl6ZiSDordzZC9nASJWK68FnvLluHdM
         WUAjTen0/GjT5LemTIal4/sonAV43K4TX5FTlult16b6B3w+nAKleLHHiN881DO8JlVJ
         0TwQ==
X-Forwarded-Encrypted: i=1; AFNElJ8rtIWX245tRjzw8+GQo8fgPaPQA3GBwkaMH0vbpoYKKdAQpWTjZgEOc/H1HqvLhZi0VHW8zi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeeH2TfBNhvug6uvjfzOq4O32Oivr3WF+JrlNGyqWZlSDDj790
	iUa2vxQeMq8e8NBDO0CESixq7sMgSCqtCeQWA81dzfsNNUcoTK1BUSZ+dpZff5VN92jgRQfPKIE
	bpSEXmyve3/CbUusg/fGTNckBSQI3sUINUMjnZRmYnTDsALlaqmJlwmWqXw==
X-Gm-Gg: AeBDietASiAhX/0JnbU1BpjIhZH2c1T3iJQ/n2zRP6o67nK+ARxUtiWwqM73RSZ6fdO
	ffZvGfa4/e/cWWR0LQXnwlbdtuKo9U6zArZyvckWzlLzZ7ZmS4Gs4oQkBR0+qPJAxxdBu9Voo5K
	QOrbVK8Jh+5UnXfLRYaKncUcIjG3/bdl2+Muuhx9U3Xh2G0npLWTyFRsDTkfOdEDJejYdIzMDku
	QkO0uleAP/PfPJtBHruDFb1icS0KeOFN/SNaiI+GcYazMboVTJDYp1ILlc4L/pY9deJ9VzhQ6cw
	90ulJ5X9aAVSIQQpS4v9gzZ1QRX2YdzslkWU4zKyxAJh5fruxmWvlNCXTfxF8t4BE7PWxWPkThu
	dlSy+XYCWyy6lp38smLotyKDIxdfMQmecYeIKH8HxpPU8bkoqQavyRNdq
X-Received: by 2002:a05:600c:681:b0:488:e192:6fbd with SMTP id 5b1f17b1804b1-488e192710cmr86691345e9.30.1776153753354;
        Tue, 14 Apr 2026 01:02:33 -0700 (PDT)
X-Received: by 2002:a05:600c:681:b0:488:e192:6fbd with SMTP id 5b1f17b1804b1-488e192710cmr86690905e9.30.1776153752818;
        Tue, 14 Apr 2026 01:02:32 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63e4f16bsm37458714f8f.26.2026.04.14.01.02.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2026 01:02:32 -0700 (PDT)
Message-ID: <67d12c45-6c9d-486f-b3f9-7fc50ccc9a5a@redhat.com>
Date: Tue, 14 Apr 2026 10:02:31 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 3/3] nfc: llcp: fix TLV parsing OOB and length
 underflow in nfc_llcp_recv_snl
To: =?UTF-8?B?TGVrw6sgSGFww6dpdQ==?= <snowwlake@icloud.com>,
 netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 linux-nfc@lists.01.org, stable@vger.kernel.org, horms@kernel.org,
 =?UTF-8?B?TGVrw6sgSGFww6dpdQ==?= <framemain@outlook.com>
References: <20260409164129.GO469338@kernel.org>
 <20260409185958.1821242-1-snowwlake@icloud.com>
 <20260409185958.1821242-4-snowwlake@icloud.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260409185958.1821242-4-snowwlake@icloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,lists.01.org,vger.kernel.org,outlook.com];
	TAGGED_FROM(0.00)[bounces-278328-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[icloud.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DCC3D3F6E62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/9/26 8:59 PM, Lekë Hapçiu wrote:
> @@ -1300,11 +1305,17 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
>  	sdres_tlvs_len = 0;
>  
>  	while (offset < tlv_len) {
> +		if (tlv_len - offset < 2)
> +			break;
>  		type = tlv[0];
>  		length = tlv[1];
> +		if (tlv_len - offset - 2 < length)
> +			break;
>  
>  		switch (type) {
>  		case LLCP_TLV_SDREQ:
> +			if (length < 1)
> +				break;
>  			tid = tlv[2];
>  			service_name = (char *) &tlv[3];

Sashiko noted that you are validating a single additional byte, but the
code reads 2 of them.

/P


