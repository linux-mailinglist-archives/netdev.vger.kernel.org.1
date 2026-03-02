Return-Path: <netdev+bounces-262732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKz7MDq9pWn8FQAAu9opvQ
	(envelope-from <netdev+bounces-262732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:39:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA801DD0A5
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E6813098CE6
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 16:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8C52EBBA9;
	Mon,  2 Mar 2026 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="xA/PqcUs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9E12FC874
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 16:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772468328; cv=none; b=ietJ/g+RqZG6ebzGjWB064Cwu8ZIykY2pkW5CsMws07Hm/CO9oV65vWCRge4qttVDn4mbdrKJDZ+Yf2+kWQLfmGaZ96+9TdzeHEJp33TjBE/vnk1Xr9zo8o7oitrPDpfMgDY8+DXkpUENum28m38DKNXpJ3TKa3s2gYvKkXQa5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772468328; c=relaxed/simple;
	bh=z3qZiu3TUBUnuOjgx/v4RhppBC8n3v5ASQqyFs1TYmY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpqHtiRrCnvu2KhJ95EayEQ0bs+SFTnYbtc9hTdmE1AP72+6H2yYXKKyrDcqah8q43O2Qt+jhM6cG2WX8LB/ZuOrOvBQl24VAey5qs55g1rFtXDnn9tpx0qID5Zanvce5M7sTM7tHasFGHSJ/bNQ4uTNRvuV5HfTS2bp3DyfyU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=xA/PqcUs; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cb4097794dso455379085a.3
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 08:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772468325; x=1773073125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdENma7XyRiM1pk81VTBz0JZaRtvfd/A0PJpVeBK5lc=;
        b=xA/PqcUsjRjFY+Zewu54wueQSO6vuP/DiKOh+CeXR3lRuuG8W04UoibX5F8IkoQkBc
         zVh9aGYlRmqvWP3bcfWgLujtG76PHqBaWYGpj2hbYbx+mz9HZ0kBxvowQLOFxyZcY/2N
         fuVVVYHVpD3iRRK30lYNRT4M3nNxp2U7Kl7FZpxRiizQ+KviBuIz0OnKZqrxZ6rS6cvj
         3a3m1mtrjSwyee+k91s9VPYFktx6y06iD70NL87Cju4nTb/4Cd6OKUPWeidBTX2zLCYy
         Gl/eXDTusfSRtqk8PqxL3ThSixVVpsmI7wNU3PPvvnVlrPwUVUbU5RnwJWcCF26arMlN
         KkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772468325; x=1773073125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WdENma7XyRiM1pk81VTBz0JZaRtvfd/A0PJpVeBK5lc=;
        b=Qzl4cicnC50aRknhiY0BsVbpOAodaz8sxYd91CssJp70XeT0BnbrXtAQ3P+bUKFYxy
         Du5UF4yBCDzHrPACOHliRo626Nktq3hUbyciv4cEb5WpMr1JMYwVm3JFvFlIJTerLn7T
         4RljNdG4kUfm6t1yzyuet4Qc8/oGJR1Qebp2pHBWj+xCI5AJ+bcOn6lNtHw7dAH8deje
         0x9fYsAKhvEjkJlZSWwJFlthCOeB2/rPPKTwJCdryBQ0TPBDuXEFrL2L9p6i3OLednMk
         xXMIlYmrfFxA5LR1okHWNbfqIGyWPd7vih6XFbMh5/wgd1pPmBpIe0P+2I0ZIYblhFkA
         1ebg==
X-Forwarded-Encrypted: i=1; AJvYcCXvLiJbF56IYGr5AuXqop9aVb18yfwddKSjitFaaFF6gE2dTJS08mjBLi9tuctrYiJ/scKZUWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQllVD8RCalZ6d8f09BHtfF0297xUV6X7+H9kQ6AVunJa8gnuw
	GZ/q0h4qYtMXKtXet6VNVnIuSuv5NkX5dnIxk04toZsvRSmjM98ml8Y2npufKheAt7s=
X-Gm-Gg: ATEYQzyfMa9rof74tXzq5O9fYXtfD5bWF1FIVl6qJ4W9Dch8v7FkDgnGMFfCZB/1FBE
	tlu7jD2uRgnzdx+RLRZ6n2gH4d2sFvtudXbReT2B1jcoRb3DySfSMdxSTgG6jl9uV9q/9+6TwxX
	UNBqbJiEPHxU3YqeePff6bfbExxDIYOWOY7f7Nb3vYylzpVHZK2VrKJJqmO/4DolzXFT0Rg/O1g
	wR32IQvjyR+R10v/+Jr+wQopmRN7DQs+q+goJ57YECVUzw+earV33+ozzxFazx3ijHQI5p9GcoV
	j/qXAUXx/VhkVnejZMcyGm2QlfZUiF3gU4NgMx7VQJ9TowuZ2695mV1GRl1+ZJssKTy74TKzzOi
	Mn0vCoqvlI0LEoT5pndcnvJkHriwNp/Gl2Tc7Aj/eje8HxOnBdbQiy91/PWjHwxf6UO4biXZHTX
	cqFRRmtMHwJxswDRIxTJKPFyJV4HxDeR+feRs8T1iBFOfXp0GIu3pOeNUrJA4MTrpr
X-Received: by 2002:a05:620a:460f:b0:8b2:ec1e:fe24 with SMTP id af79cd13be357-8cbc8de8509mr1373887585a.42.1772468325469;
        Mon, 02 Mar 2026 08:18:45 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf6f940fsm1208727485a.23.2026.03.02.08.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 08:18:45 -0800 (PST)
Date: Mon, 2 Mar 2026 08:18:42 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Yedaya Katsman <yedaya.ka@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Andrea Claudi <aclaudi@redhat.com>,
 Luca Boccassi <luca.boccassi@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] Update old references to /usr/lib/iproute2
Message-ID: <20260302081842.17003c8a@phoenix.local>
In-Reply-To: <20260228-usr-lib-to-usr-share-v1-1-a09da2a7675e@gmail.com>
References: <20260228-usr-lib-to-usr-share-v1-1-a09da2a7675e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DAA801DD0A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262732-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

On Sat, 28 Feb 2026 23:03:59 +0200
Yedaya Katsman <yedaya.ka@gmail.com> wrote:

> In 962692356a1c ("Makefile: use /usr/share/iproute2 for config files")
> The path was changed to /usr/share/, but a comment and a define were still
> using the old path, Update them.
> 
> Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>

I would rather remove the #define's in include/utils.h
The file is internal, and everywhere is using the values that
are in the Makefile.

diff --git a/include/utils.h b/include/utils.h
index e0a9c780..adf6a581 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -39,13 +39,6 @@ extern bool do_all;
 extern int echo_request;
 extern int use_iec;
 
-#ifndef CONF_USR_DIR
-#define CONF_USR_DIR "/usr/lib/iproute2"
-#endif
-#ifndef CONF_ETC_DIR
-#define CONF_ETC_DIR "/etc/iproute2"
-#endif
-
 #define SPRINT_BSIZE 64
 #define SPRINT_BUF(x)  char x[SPRINT_BSIZE]
 

