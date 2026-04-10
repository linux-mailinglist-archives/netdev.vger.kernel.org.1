Return-Path: <netdev+bounces-277254-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L/BJ/+Q2GmNfQgAu9opvQ
	(envelope-from <netdev+bounces-277254-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:56:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2AB3D27C0
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 07:56:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B81B30172EA
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 05:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDAA33B976;
	Fri, 10 Apr 2026 05:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wl4nAPfL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CFF2E6CA6
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 05:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775800556; cv=pass; b=XL0OcfYKFoVfY603OR9UUWr7yAFfPG9xQaW/+qTEZgM0VmGnJqNm8s8SN172JgPswnGWKMfcPqvT2zLG/5nqT1B8fAJQk6eTM2k9xG3ERZAk/QcgDiXwt1jzYExLFLUQpOdrw4xvaorUqz1g0slAm3s6UJ6Aj79HDbA/0RHut94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775800556; c=relaxed/simple;
	bh=zsFs8aJa1Rtk2clpV5GU9MWFWEtDSHAPJAs8ArTYXy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BEG0zr2tcyIAYMAhUMkb+5lAcumoiOu0hKpmpOyMeQSecvfyqzwZezyotCG916DxdHHP7TDhN9VCQBUfhoZ6fKtaZ06sILurJrg7OCEEO3sm2WX6fpUMKR8C0iAksy053/8MZb8/qES/c9MIY1OwI/zWRMdA1pewqrMp0DED+as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wl4nAPfL; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-128e4d0cc48so8983803c88.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 22:55:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775800553; cv=none;
        d=google.com; s=arc-20240605;
        b=aN7sTskyr3IMrVwfAXzta5wpXSqvSVSsVNsX2NxDUcMw4lsnN4AJlU3BwC3PmhCa7X
         wbe/eddsz6wMA1QBS814LbszOWYq3Hn6xwBGYR3dNrucXcXOXEd1jX3siDtjpkQp7Gus
         oY0E252ACpYATYHAcMulEkUV+064wcywthuJ6pe0LU5zVEHw7ULh1gdk09nXeijpSevm
         m6QuE2mlqulPu6NOgYkuyjkymvHOYVjhnMQIiL7SqOh79jEVdAlSODyDyCYZnH1Pz/yq
         rP4Fxrp6lG/We7H3dVDUmGBnUn8/S/S7QpNjX89y+qxn6LY/0N8LsD8v6z2vlXMbenLN
         19Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zsFs8aJa1Rtk2clpV5GU9MWFWEtDSHAPJAs8ArTYXy4=;
        fh=GxdJaVJBNhIbnS7aul2FjNcEstY60HXOzBaJO2V91OI=;
        b=fGoUmUd3LWOccSV9c9qdfEE3fFRA+K3wZd/BSNIRtyGsydvPYUYyjrIyfN5chZtiqw
         D/Vg6xRBlkCk6U0dBD/GalytQxsZQBBuHDZdSSK5CztrXd+ZLQRkIZS/wqInCs+sypFB
         qua40X3Fl9cCkxVHmdzIOaGdhmHJqO7JIW7kEG5EplFwzg7KD0jn8cDvTRLACmW6e40j
         cYsXyICN0ILE3pncovxwbBwxH6t60wFt+pLmZIl2ZniSeLsFpfYtzYA7Y+kNeYrz+EEC
         VOMRq1KzII+EXCZw50q38WZum63BnKUwXbOxTYeEiEo10DFcpelo/y8/efkiRMCxhGgW
         B8gg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775800553; x=1776405353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zsFs8aJa1Rtk2clpV5GU9MWFWEtDSHAPJAs8ArTYXy4=;
        b=Wl4nAPfLQr3/ney5qrERTfdWAvnl+GMlJ3Pn/CPOO/72F5P9uoa/YuisRqZ3+kDN7y
         E7v0PUZWI5LaRDs2ibVsSTpM87PiFtuJpk3NsRQSav9gFPWbD7Yse5uMisXNNLceWZix
         78xgFohJ2U6csys6sZ0y2RjBpAffkKq0DyMOWDYoXQqAEbjWNYn2qgXLs+ySf/bfJJLG
         GzIzvga3sHBEcHNs8W5ngsLazFxxqcGa0qxPuxN3Dk/ji1intyAP/kgw7cCPrtsn9qxt
         HudqqN59uxX3nBERtgZoS1wqdCrmB4u2ZfOFXHhj7BWzOUsp9/DkG28eOjs8R3Lsoo94
         h0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775800553; x=1776405353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zsFs8aJa1Rtk2clpV5GU9MWFWEtDSHAPJAs8ArTYXy4=;
        b=a02NwTu7mNZQ+puA3UAHKdbjoV//naxxOxY7jmLNYdidR2Lyh+l4DJz8bedCSC2Q12
         IEwpVzpB6uLeTlPx7DKwaHPg2e5kPhpB2UmWUNyJc8Z8e/Z+OCqPYIxa3pt2Je5oMrN4
         TmLVzeeekOxiYFkSGhV42Xssz5cutCth/oerOrgY00LgUXlle1BsC93zrNZUg1RLI0g6
         7niG893jcbmeGEeCrU2V8SIahTCi1J5PiUln5AHA9GwGBBtZ27Ihst3vAI/oxF2x8kgP
         wF1f+VrVTftCPHmJ8jMYHdnoDW5MSHHpTk51ePPOyGpR5P++JkPYxu5lOhh0fShL6L6D
         zbwg==
X-Forwarded-Encrypted: i=1; AJvYcCUTRGESsWOx9S9a6kOxy9mfYRMdw7nOPHsAuRz9Vuk/UW5FTQTaKBEGyhojas74uBJcx2/RgfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBIVixFDaX2MvLYa1YH/fcAk1acwdgm8fQxp5/w3ZMJzWm/ccS
	uf9gKYeV+mpEdx6oifgLExtrMB0BrRNjCS0MEB8JRSMdP+lG+Va/zoMudAkMZd92Izc6RWaRqU4
	zi7K3TA/x88N6BwWoVrMhBqSWLDWKXXxN+zkX09U/
X-Gm-Gg: AeBDietU4NhC/8aXj4DgPyFKcOxtSEPJdf0SIY9R7Xriq1mz1l3asATUaBe7srPQg4n
	2onwL0hmr0x5OMkfPoZebr61hFiCz++vdw59kL1sde6XXpX7p7A2ucEzwTS/QkhJpupIMnEhR9L
	2ERxy9hHynu2gwnpFJaDVzHCZm6DVjd1ss/HqsUD3KWVkr/aSrE2QjEhM4gqWdDAQzqLzufQUOX
	2iY3Zv9JW2PWgXJqUJoBXXQbACd6Vvtzo8Kb1gTWW5uoCqbFG5eMcpBzOIOmeF7IlfnHjYRKoYO
	Oh8dLnfRQdl/sQLDdhiIDnrrsLPapQYRfntna3D75R5Yi1xR8JKuZ05fePQMFUsHK4gcUY5sVBw
	9HamSOj8=
X-Received: by 2002:a05:7022:fb04:b0:128:cf70:9042 with SMTP id
 a92af1059eb24-12c34edf629mr1103279c88.18.1775800552143; Thu, 09 Apr 2026
 22:55:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260409-teaming-driver-internal-v7-0-f47e7589685d@google.com> <20260409-teaming-driver-internal-v7-1-f47e7589685d@google.com>
In-Reply-To: <20260409-teaming-driver-internal-v7-1-f47e7589685d@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 9 Apr 2026 22:55:40 -0700
X-Gm-Features: AQROBzCzBsO5UytFkgNpaNB1wf3i3tkTQw_2DlCMSHnBaWMLUNQ--w7P3T44UD4
Message-ID: <CAAVpQUBykySBCZ-d0oGzKoNAA+NmkHgDzFwy37ON=dYpXEryoQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 01/10] net: team: Annotate reads and writes
 for mixed lock accessed values
To: Marc Harvey <marcharvey@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277254-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 9E2AB3D27C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 8, 2026 at 7:59=E2=80=AFPM Marc Harvey <marcharvey@google.com> =
wrote:
>
> The team_port's "index" and the team's "en_port_count" are read in
> the hot transmit path, but are only written to when holding the rtnl
> lock.
>
> Use READ_ONCE() for all lockless reads of these values, and use
> WRITE_ONCE() for all writes.
>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Marc Harvey <marcharvey@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

fwiw, Sashiko's review is orthogonal to this patch;
the comments are for the existing code before this patch.

