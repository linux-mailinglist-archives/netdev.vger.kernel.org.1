Return-Path: <netdev+bounces-274595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MgMLySGzmnfoAYAu9opvQ
	(envelope-from <netdev+bounces-274595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:07:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F45138B0B7
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 17:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C69F03003D0F
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 15:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F413EC2E1;
	Thu,  2 Apr 2026 15:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbsyW7eS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3882D207DF7
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775142372; cv=none; b=LV5/I1QtueKmz7HHz+yaucIS1q/0tWp4nfw3d7d6WRfCkE0RZCVdon7D24EYzQo8/LqhvoU60ukzz8Oz7bFQFkXHJmMCsrxzBtNqt5DJ/sbHvuJrJrZgEBTjNlX4MFimORhYxrIVubLYAzgHc39RdqDaQTIehJ3NR0DKS2OyXuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775142372; c=relaxed/simple;
	bh=pUnsQ8hrWA9FDAWUFzBYTnamZlaoNs3DoOd2vZT+Im4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8Q4X6NVNwi9pcItBUjDjcEv1ssAnnw1G9KXkJOgK7tHiQCFvq4iFWN+wKS0cJEaxhym0fubW7Xo7O5lcd6qdnClZJX3gL5o8mLPIc/DiB62xxbw5tV5t18j6IzhnNLniBWVBPbvqURmvIMdKX0qpxShkpt6EXCakzZVLom3eCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qbsyW7eS; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b4520f6b32so1195610eec.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 08:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775142370; x=1775747170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XSCodcX988r60q6ljV1fu4dW8EF3MyDwPr7Ap09ibhE=;
        b=qbsyW7eSiz0QyQll2gzDdvPEetMdyamRuB6G7vMnGdQkhWzGFPiOd0LTRbPGyr3Ioa
         20Y7H8zHiiK9R53c76AcQZ0JG/IknfyY/CKh88J/JeD70NC8wGI+W/3oVNVsHdCU8eGA
         UYHyEmDCQeEB+Uf5MWisUZmje4C5BIgh3+qur6Tmju5+CbV42NEjMJg7kuoa4w4F7qpo
         5opfsdv8L0BfzpLzSykCfRSHT4WxDt1bf7OArHzXgq+ZBRdAmjAqM+i7wechbqvr7OwV
         ydyoJmwRTfQqa+WQ5LHfBcxElPT6mdDgRRuspAbyIa2beokfprn2IpJIlG+13dc3ZmSx
         YJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775142370; x=1775747170;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XSCodcX988r60q6ljV1fu4dW8EF3MyDwPr7Ap09ibhE=;
        b=EH9A4YT6JHEsuySN0ftciLFH64lLWv7Nju8tkp/JJXEMrlQ2Q4g3yq+BLrUP/vurNV
         4Pz5iKXEbmn4iqhbz4SqxXbWOw0gDJrv6ql0CWn5d0P9fna3f7ERZhfNqSo0844Hgo4M
         iu0eT5iusCQBvPEfweDJgKxCLdx3vej4M9RQAM9kzQMRwXIxu6KPlG01Zw1e0GSrjK2c
         GSoToMZrgQssV4eRFtuzA0+C488k0Yw/HQDlH4pRCaDn1VEOUbALDYdqW+9X4Q7dWbMw
         ZjOi8znyWslWvJa1rCJxyz3puqOAXpmHqhBp3mLx6boucooyb2SN9vemETtZY0xLXgtF
         2EGw==
X-Forwarded-Encrypted: i=1; AJvYcCUdrJssWkIAYsZE3xID5IiAt7p/ySpV5BadcUtoAUHlWiXl2WpIaFbqREndGD86IOz2Eestd0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbC6GPu2hapJmA9Il7SmSwlApp7FmJqdzJFvAEodTUTuHBPFnj
	nnWY5nufMwHfHC6S1RbLhl9l7pOcvE++4s5fWDm397xlJChw4LRDnOw66Wvc
X-Gm-Gg: AeBDiesQ+AQRGH2sFCZchC+ARE24W9XwmE49bO6cnke+oe0VJuPsJKJPEbAiCVEsQFx
	nFFkO/HTQTR5uy1Kc/oCR7cMoUbTQILvMoteLaQ4Xs5/Y7eEUuE8Ta5RVGJnL5PtC2ij+WEjPDb
	LhcCe4CAEXgPBp9vY8Gp5VB08+EwDApNgnDRMnpnJnHLyRF5bYvWYYMcRfAd2RxCFuKhECp4xYi
	hLf4xBLVucsn6JoI39V1ss7nxEX+fNul/erRcIs6DQYtRVe9GlutaNxDHUylQrL8k/Y137oHot/
	NIPFunaQukYk3yNq9yk5XeQB/UmSYyZoO6kO2xD0lCyJZIg/fIXunUpaB0Z3C46oFNNI6ylCABz
	xmLeTN0jrwriAdBgUffWFaouNvrouGP17CXwwX+xt+NW/e4Q7F7t8rB+af7c2ahxz6mxgKI7ap7
	J//NlVbaN9sHF+JyXY9K+PdQL5RegZY6E97AZd43rZdgaDJWvUM7ZfdDSNFhI0QtxFZhKEYPLYh
	4FHsGZjdPYx81zuGg==
X-Received: by 2002:a05:7300:fb8b:b0:2c3:b172:83c2 with SMTP id 5a478bee46e88-2c9329a0fb2mr3918473eec.20.1775142369953;
        Thu, 02 Apr 2026 08:06:09 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cafd073194sm1606138eec.28.2026.04.02.08.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 08:06:09 -0700 (PDT)
Date: Thu, 2 Apr 2026 08:06:08 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net-next v4 00/14] net: sleepable ndo_set_rx_mode
Message-ID: <ac6F4G-C3kltoVS8@mini-arch>
References: <20260401011914.1716692-1-sdf@fomichev.me>
 <20260401203831.6deee0e4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260401203831.6deee0e4@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274595-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F45138B0B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/01, Jakub Kicinski wrote:
> On Tue, 31 Mar 2026 18:19:00 -0700 Stanislav Fomichev wrote:
> > sleepable ndo_set_rx_mode
> 
> Appears not to be "buildable" on 32bit x86 tho..
> -- 
> pw-bot: cr

This is what I get for writing unit tests :-(

