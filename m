Return-Path: <netdev+bounces-253790-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HgvKeqLeGmqqwEAu9opvQ
	(envelope-from <netdev+bounces-253790-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:56:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A08922EC
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C93653002518
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 09:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660C4335096;
	Tue, 27 Jan 2026 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="fZLJ3Q6b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C20B278E63
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769507477; cv=none; b=kjHCRznZVqU52mM1ePp/TVD/950A1tj0nhDvOhZPnTg+iNqGTyA5u0jJjCdKlzIdMZeMxRQLSa/uIJaQDMB6SgbI+FQDSgvxG4vnhvl0PTazKExq/84xSGLSu+mWUzfgQ4Iy8MuOAGamYxCG0qXNt/Hjee04rxCF+V/Op6RHgQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769507477; c=relaxed/simple;
	bh=luuMhjbbq0GlMuoXclwQOgCtRpyS712Z5w1+3a994SA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTK79sYJPaMmsAFabIUQvgTs93X0B5uVR4RPKfX+puL5zB2NoaBywl//ohlqZBEkfXKVzLNM2fzlh5oLOy9tJh9907eQ3M4rtkzXuzMDXkDnD6Da5pZYXUS4j5wazNJI7WtbStWjfwDoXpMY6LviAMKLbiE1rrN5i/H8gvlTgbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=fZLJ3Q6b; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-432d256c2e6so5208762f8f.3
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 01:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1769507473; x=1770112273; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m4Z+XKbFJCQTXAQ2Mgr9fcEDIwslB88X62y88yyhlzU=;
        b=fZLJ3Q6b5U6FraFqCuTG7dFPXobFcPtoqMECSGB0eUfuwtiqsFsLK/GItLia3mr9ew
         n5i9a9d4Y9d6D17RPPGwhwa07wNb5SA3aiF0VRDKt+ElvVqWXuEPZI9qEHjQsVjTo7p9
         aL9/a7ysrYmgY8gdZ7Qb4ZI8C7TuX/FsgWK4oo9pboFpXw/QiQU/XZveUPJ2Wu8YG2PT
         qdQ29j2/FP9vG4wn5QIq11S8zD8FGPXRdiRS6fGwu2kKXc51L0Id01sd/heigOQ9THmx
         +I/T8+iIgftnqX+YSTiLNAu0oaukEWy50C9FfsdFHGeTvV4U8usiokf1CKoEwd5Isu0K
         8x5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769507473; x=1770112273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4Z+XKbFJCQTXAQ2Mgr9fcEDIwslB88X62y88yyhlzU=;
        b=EHFXVHWDecoUJLIrdaBfgjHUlk453MS/78S97p8TJ3XkqTQqgfxll4IbMMo3YAkGU0
         FZ1LXBGZ3wJ4QitutUHECVa9vtYJj4/mYUJ5hlqxH2CN/nWzDCEKHotJXj5KNoMmodRk
         gmwJ0a5Ka9FQEMR67VAABHA60xCHzt5Glh+VuqvZSmuSR8qso80FulTJ8fQJG1RDPcHX
         5qu8OLBtO8DpXx8zHxPW0dfdoNP5rb4Isfsj3W+IV2IzqqT+F0gJwU8+i4nFDv/aPGaO
         lGVljB++8Ki98+KwYBchkyfWeRH4ETvTHxBfw/O+vbjM/BrmqsSf9yFxz6O0jO8prXk7
         9VEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrqoYsOkJiq0HqRPqFPCOPhgJOS6fEKxSk6QZ+ALaqUgAPbdWS3JOCh++DqnQBbG9Efcd9rOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHuJXJM/UsuCE2S6qcNuI51Fh2ubr2KdozT6EwXJwQng4L7If6
	SmMXxkBSDOx523MoVEyJZCKYdNYXOmcIJA4R6SjYG7UcjNIG7ALCNCkzwUFkbZjUbFc=
X-Gm-Gg: AZuq6aJ84WDs3M84VpWVPchxATqwlRBJgL9jhkQHe8xXyGSa1fNI/8d6anc1B2mgvrx
	Q2xeWlJZTY51DB3jvRY6MQg/5osdGqNnlCHKz9JRvZpasXlFCl+qap3XkVcnye/tX8PIk9HSLwp
	m8u+vq9s97YDzPo1MN+bNb5+wFnGsKo02HT/rAfT2+AIFjSKP/o9qRaIub+I2ZDlG3D+TROFK3u
	80kCZcnEBf8VUPRs9peZgCxtlvk0602/z0qpPUxRZQha1YCifEwPwqK8B34bBjsRwBJu+KYNAeA
	TEX+H4fQvTyeU5T/3sWPPDBS8ytYNOY9R/oZeyV5epd4qN5J5xPf5ZbGtdp3ocI4axZh1zaTSNP
	KyuQ24fvemYmPLas+4ao0/ohq1hi3dZ4O2WHydsIO7UoqNsTpqJeuUptWbtALBA1Wgf0NVdG3w1
	uvtr6RT1lQz2/BFZS/orMn0yc=
X-Received: by 2002:a5d:5f54:0:b0:430:fd84:315a with SMTP id ffacd0b85a97d-435dd1c0c3emr1722911f8f.39.1769507472561;
        Tue, 27 Jan 2026 01:51:12 -0800 (PST)
Received: from FV6GYCPJ69 ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f74942sm35554428f8f.36.2026.01.27.01.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 01:51:12 -0800 (PST)
Date: Tue, 27 Jan 2026 10:51:10 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Ratheesh Kannoth <rkannoth@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Chuck Lever <chuck.lever@oracle.com>, 
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>, Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [PATCH net-next v2] devlink: Implement devlink param multi
 attribute nested data values
Message-ID: <rsngz5ql5s54luv4mnjs733uogjjdxiylbbm4w4pcaefow45rm@memr4a27ycc2>
References: <20260126023946.906893-1-rkannoth@marvell.com>
 <20260126171859.5097dfb5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126171859.5097dfb5@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253790-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[marvell.com,vger.kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,oracle.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4A08922EC
X-Rspamd-Action: no action

Tue, Jan 27, 2026 at 02:18:59AM +0100, kuba@kernel.org wrote:
>On Mon, 26 Jan 2026 08:09:44 +0530 Ratheesh Kannoth wrote:
>> Devlink param value attribute is not defined since devlink is handling
>> the value validating and parsing internally, this allows us to implement
>> multi attribute values without breaking any policies.
>> 
>> Devlink param multi-attribute values are considered to be dynamically
>> sized arrays of u32 values, by introducing a new devlink param type
>> DEVLINK_PARAM_TYPE_U32_ARRAY, driver and user space can set a variable
>> count of u32 values into the DEVLINK_ATTR_PARAM_VALUE_DATA attribute.
>> 
>> Implement get/set parsing and add to the internal value structure passed
>> to drivers.
>> 
>> This is useful for devices that need to configure a list of values for
>> a specific configuration.
>
>Could you respin this as a series with the first driver implementing
>a param of this type?  We can't merge an API without a user.

I may be missed it, are you okay with cleanup helpers now (__free(kfree)
used here), or not yet? :)

