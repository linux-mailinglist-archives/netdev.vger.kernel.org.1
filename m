Return-Path: <netdev+bounces-275974-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPwjLRnx1GkjywcAu9opvQ
	(envelope-from <netdev+bounces-275974-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:57:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE0D3AE020
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64267302737F
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 11:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2779E3B27CE;
	Tue,  7 Apr 2026 11:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="QnBm4EPG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB803B19D1
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563003; cv=none; b=kRFi9kUjw+ETtAegszaXGnjGgBW9HS4C8inpToCBbFx2dAEdjfQfxoGW/rpd2lvXb0gu5013M4mrHqw8SP7VvfrzYzB+BaAYsVLUhcYgCZlqxC0V8BTccY5IM7++C+e9MpjkggJU3KSrBrwR+Ul1ecCp8qSHn5HjvgLzzLFrURw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563003; c=relaxed/simple;
	bh=/Yl73U+9+hZySoBzIGlp3yaYYlVER2vb9pSNdybI+Io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QO/wFO1c1ssG0IHkXMMh39uPcWRXQMe/eAgZy7gkavlBDRAhCoM6yM7HTEtzrRb301qiKeos7yrMMQe8scualUDdJY6oIQj4HD2YzF6jH1GCGv13hBv3i64wdnovdVvjgzUFytfzSTYnJcW3SWMsybd+oxGquNXrLYD4kufUq3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=QnBm4EPG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso44780835e9.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 04:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775563000; x=1776167800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Yl73U+9+hZySoBzIGlp3yaYYlVER2vb9pSNdybI+Io=;
        b=QnBm4EPGga/YD8LUYHFKT3LfwyV5j3aNhXoLiy1KXb/NSZefWel/dGF0/BXlXH70jL
         q04rz7EXo4BZRf0TbBkNEo55w8zpxZD6TztxNervWbS68mgkzgtsgnbjtMatoD90R4Rj
         3Wsw2GKCw/9mSo5axGSulCFB0bTgecAwovvp6NbnID+fZ2Hqu8NMW6Pp2mpPCfs1Lxz4
         LZpmbJlepk/9daTAO/X+/aJCDcl2hUNywPPPSJ2aCj/x2ikEmdZF8U4a678sMl7a8xs+
         gaDUfVbdyBRNl8GTg1xWMrzuC64IfHetagZnGePsX3EGgiVnuyetUDqu4DLFGWdnHDNV
         ESIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775563000; x=1776167800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Yl73U+9+hZySoBzIGlp3yaYYlVER2vb9pSNdybI+Io=;
        b=aAeLNmR6Go2Ts1l9nmF6YAzmyxpAyMzERYkB2lKXJb8e3Q4AOedMST4XYGnC4Rtj9/
         T3VnztB2QcA/+lt2OeTpnxqvie7c3ee9ecpJ76XNsqrOzmmMC7voowuKqDpcEAFgn7ht
         BB89cyOIV1eJOQeNaHIZfvxeIdK/uFaL5rwnRSlTrI2UkkZNl5mfOhy+wR5vQ4FfP7GQ
         /gSW5jFieKeb/JiXUO0ASyI/ODfAm5JRMlfyYBRlYiQuvtjzzVp/cmWejAIFUzKFILuq
         RZyfOmA3lHJchrBfcJTxSxnaHhVhhmpLKf8FwOEdLn3M3bsBQzJRdIKQokVINpJfhAR3
         jJuA==
X-Forwarded-Encrypted: i=1; AJvYcCVa1U++mjmj8K3vqPYJgH2sOAxmfHCgQjwuupke4zOzHfSp9U+kY4wmCxuNAyCYmVu5bPw+06o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxZkLIBPFc0f/mllaQ1LVtOXOLqmWj5ToxxrPIsVSSlfJM9b+b
	P5TFaWY5yyAeB4/ftomeneEM+Q3eqI7/bPy0pFtp5Tm18UpJDRRxKYkNjwmUqYPOTMM=
X-Gm-Gg: AeBDiesgMYtdzCspsqlRtuaUwQSfzuR2FIdxa40Z5/mJp9uVA7xS9hl0cCwLEBxs9Y+
	Lz6LrQK/FY/T1AEwgfAyqA5WCorYxnW87WEU/i7tdwBPn5Iiq+Wp1ipqOmiqopZEvogEeZqOKad
	uUxp1cp56j/XsUUM2uixnjcV/7iUheA+koRRudfRBjSKxj/ORMG5uaECiPlsPQvSu8cukG2XbWL
	Q5rmavJSS0Dg5KpKqxUzzfw5rMhr9qMDyXcyY4MB5ucuw+J+H5nPQ716Pe9QnXZoUrPD9gkPOD4
	8xEqFdY7TaZMOuX6t7Lfq+FHT/8AkQ5dahLU7jQjK9vw1SoOyXeuc1WYRrXP1MqV30TljYxpogb
	UtpQ9BwqFeq+CAbLWBpez7YPf6LcGFQXp7qDT0MjuhfhxombqKs1xWZfhiPQMl/JZREPNpkhGFI
	LBZeGU2p5w3uox2aaf1yPWFBJgyagqKq6ae2y0Mrvlgg==
X-Received: by 2002:a05:600c:e40b:b0:488:869c:eda4 with SMTP id 5b1f17b1804b1-488997aad9bmr180106005e9.21.1775562999937;
        Tue, 07 Apr 2026 04:56:39 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48899e7a024sm116032235e9.23.2026.04.07.04.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:56:39 -0700 (PDT)
Date: Tue, 7 Apr 2026 13:56:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Marc Harvey <marcharvey@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 06/10] net: team: Rename enablement functions
 and struct members to tx
Message-ID: <iy5qqgpyajolnyhas6jw6ojq6abvgxsopifn6uiha3jia2lkvo@miuj2vnsmybk>
References: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
 <20260406-teaming-driver-internal-v5-6-e8a3f348a1c5@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406-teaming-driver-internal-v5-6-e8a3f348a1c5@google.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	TAGGED_FROM(0.00)[bounces-275974-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5DE0D3AE020
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mon, Apr 06, 2026 at 05:03:42AM +0200, marcharvey@google.com wrote:
>Add no functional changes, but rename enablement functions, variables
>etc. that are used in teaming driver transmit decisions.
>
>Since rx and tx enablement are still coupled, some of the variables
>renamed in this patch are still used for the rx path, but that will
>change in a follow-up patch.
>
>Signed-off-by: Marc Harvey <marcharvey@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

