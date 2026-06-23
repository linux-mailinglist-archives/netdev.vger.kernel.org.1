Return-Path: <netdev+bounces-301483-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TFQrHDHvOmo7MAgAu9opvQ
	(envelope-from <netdev+bounces-301483-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:40:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4446BA10A
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:40:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=n7w3WnIC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301483-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301483-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 71B7E3001CDB
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91EF23A48D9;
	Tue, 23 Jun 2026 20:40:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBF9395ADC
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 20:40:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782247211; cv=none; b=eL1E68jJuMrTYZULkyscU0Y/jS+JuNmsnBSwn8Q8XxfRQf8SBPS0mPcxzTXjtO3qfj+sNmi8tOoDOlagPcm/PPysr+ZygSq8lr4n/cgrM/R+NsbRlqgxaQnjPtJnVL5BRJ8l6LD/XqKaRcDrQOC9wQK5Fz2WFmFksYe72YGtmBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782247211; c=relaxed/simple;
	bh=WxRhDkmyHYSaJDOtSuhOSEqOcn39elwhzHAyhk1eWK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZeJsidCgxtIq7q72yJQrthUjTmmSaSyLKiuyVLLEXqlWF63xk/zCl4iUiYhGaxAfrY4XO1ER5Qq+XplkMjPh4Jy0Oyd3JdammLYbRRwsRsAI8ie1R8HD3pkHmZXVDhWq8o/8Y3lRt0pix1/aS4YnzQ1QXZHP3hJ8d7JcozT7VDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n7w3WnIC; arc=none smtp.client-ip=209.85.221.51
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-45eeea039ebso178191f8f.1
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 13:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782247209; x=1782852009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKvfi6e4m/bcxUZ+joIujvCFdP+/ks0gLM/kKthz2XU=;
        b=n7w3WnICs8WF11H/rYM7v9bi6ox9g12O0pZZ54ErBl2Tq1WfmD93A6VxQ2Z0E2xbly
         jJ5M5wdp7/vSorKf9l6OZgbLWE/uHXZrBbpWBBb9oK5nJ98GttNVhYdoH8y/DT2O+tmW
         ArjY+BavNmpEKeB/J8liRRSOJy0bz8Zew22a9nzDwFi5ClbtuoE126YGDNladn7m/kTL
         RtKcoPZ5SQ3XGYKaN4WY303y0uxwSRFA8TfzwNU/rhpQ6JhQwnJZwwCbRTgJv67DszKx
         WyxB4UogJGXEFc1gejbNyrq9CobxFo/OAAMG5WqXBPQA5mxSuM5/Ziq1qR1NsnCXN8m7
         2btQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782247209; x=1782852009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iKvfi6e4m/bcxUZ+joIujvCFdP+/ks0gLM/kKthz2XU=;
        b=s4NdvFTKGSsNK2b8Zo5LZD+RAkR6AvkmUaiI07UGaz4auHPelJmayQ7hBZlnJHG9rs
         OZF+onywq2fK+KjCxjdiX1qXDiOD7b7CIrGHIjW39lEITsEIDf943OhgOAMPxwpJ6jfW
         8D8BBZxsfHOGl+VlPCkNuPCMgVHPSjIsjmLCncSUVKebuwGbN+Qq/NUakkiOcxLe1vnQ
         vucsRRjd2MM/bxcOQqf6sIGEwV9ksiKa6jDDAGqWeoKABtFFDwfJGhuIn0DX65x8yS1/
         utg2ORsLQnw2+ducMeEDb2larY+vmIlFnaMOotf+S5ddMkOK/lIwn/z0sFvs1O1xIE0X
         iP3w==
X-Forwarded-Encrypted: i=1; AHgh+RphzpPOXSrbAyv4iatxIgWVrr/ToJQIYZALuBjJbZziMiybJdye1DI+7Qm8i73H2gfixNIHCNE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6sTrwwDegMbFj4NGmW4mkyBZRqqeTsedG7FF/qW+e78c44tWM
	EOyk/C1RnwgGVtUVgjRbMdmPAC4GX10Aez/QWO/mCjYP3pXJAWTtdrqb
X-Gm-Gg: AfdE7ckFN0wvq4h6DAfsT1jSeyAl/y73+wxSs0lB0ezv1hohyMxj5PZIO8qmcGXfqCe
	oxvkwm5uwx+WMuE/XnCvKUMEkuBXqmEIZU+hf8xsIxoe+SSEQHR96+eOnGO/SNwdbCTADLqgn4V
	RHEgqdzq45GLIWx0TIdpLwBvZac6EjA1RJY+vI/xru9skVFebhzlLumGf5bV2ORA6c0CbCu1I9D
	ZN9hsLKma42UjAXwORPfoWTTZWLqaWzNDUZ+B1HVgEPIuX6MjpAdiqsLC4/80wSLBpTU5je4RgT
	bfh0y0G0rXZ+W9jFwYOchjmNndk3zeZYexJQno89fj0Tc9HCgcPmD/hs1vU6IfJRihdLd+IX4lK
	M/KKY9GAB7wcA3bg6eGBj6GPGaXPIm4SFSQoUc7FG2ekkbnuvnfs6Ef4wMj+hXv5T+jp/BZoYEm
	4eqNTWFUtMX3eWChpW62D0wsCe22R+YVEJCVMPuwgCfbKwwauiGg==
X-Received: by 2002:a5d:634d:0:b0:460:3233:f994 with SMTP id ffacd0b85a97d-46c0b00b249mr467556f8f.43.1782247208369;
        Tue, 23 Jun 2026 13:40:08 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c22c68239sm276534f8f.36.2026.06.23.13.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 13:40:08 -0700 (PDT)
Date: Tue, 23 Jun 2026 21:40:05 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Michael Pratte <slatoncomputers@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: s2io: driver still in use - please reconsider removal
Message-ID: <20260623214005.0602374d@pumpkin>
In-Reply-To: <20260623112133.752195-1-slatoncomputers@gmail.com>
References: <20260623112133.752195-1-slatoncomputers@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301483-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:slatoncomputers@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:enelsonmoore@gmail.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,gmail.com,lunn.ch,davemloft.net,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D4446BA10A

On Tue, 23 Jun 2026 06:21:33 -0500
Michael Pratte <slatoncomputers@gmail.com> wrote:

> Hi,
> 
> Commit aba0138eb7d7 ("net: ethernet: neterion: s2io: remove unused
> driver") removed s2io in v7.0 as "highly unlikely to still be used."
> It is still in use here: an Exar Xframe-II (PCI 17d5:5832) in a
> Supermicro X5DA8.

Are you really using a dual socket netburst P4 system!

They weren't really any good when new :-)

	David

