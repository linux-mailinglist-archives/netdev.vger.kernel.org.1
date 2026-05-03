Return-Path: <netdev+bounces-283688-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2m9EA53N92lnmQIAu9opvQ
	(envelope-from <netdev+bounces-283688-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 00:35:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 369A44B7AF4
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 00:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 354B53007353
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 22:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E2B3A544B;
	Sun,  3 May 2026 22:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="jC9YEW/c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4048374187
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 22:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777847705; cv=none; b=lmmZdce4krORifxz4qrw8ixOHhP4JGQVeWFmt5MBzUY9siExj92af/S2hLs0H91SA3+5Ba1zVyA9V3FEOC5Ps/s5z3sCUMXfc+IcqnSZaJfxgsmZVxY9tF/dFNqvVXGYn4tUO6pJNCBUDbnXELPT9U3kUJIuL2NUeb+yz7mYaow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777847705; c=relaxed/simple;
	bh=ezR2JbSQRqglA2axszZGyrZSVJZolk9/WklJDiU1PjU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m6VeqIEq/irYqYrZRlaHWHWIjlP84FzLksQ2CLy+nrwoZ/jpUD6UUE2T3m5/uiRNYIbo4MCXGR41frFIVFsiOB1bz5czE3SR6E32pTs0Td1TNEj3JnFBzg7rjMP1YrgxYRTw+O6k8vCYJjotzvCEPpRrp0C4JXOLmtum208G9C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=jC9YEW/c; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12c1a170a50so4387246c88.0
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 15:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777847703; x=1778452503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McDFBDMpcJ3Dy/f1/UalCTLWMoTcwj9WynyYk9kTDOQ=;
        b=jC9YEW/cypo9n7DvZTa8QtGpmKdr/QbOW3cPkMakvSA6BQVhrlfVa2teyIyIJxTmby
         GiqUNECBt+CT23qdt468Gmepv62WI9qY01dOornC8bWnV5+0J4fzC0wFXiZPq6Qzbn7T
         MH6lzxIPDDUL85i+MkIziIRn+XFMwodDjucE47nfAJCywZ/VmTG4acdC0Cjg6ASY/TfD
         MOXAHTktel1GZYo5yX7cjFA/Nc3VcT5F5Zn6eIhygryQW1i75ntKcqXJUk7mGt4DPZD3
         zM6zhNw+VpDBv4lqsCPS+i0du1JhUOQx75zK4wVkhv44laFPqJq4+dJZlH0X4nFH+JYT
         OHpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777847703; x=1778452503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=McDFBDMpcJ3Dy/f1/UalCTLWMoTcwj9WynyYk9kTDOQ=;
        b=WUsQ/HJg6KFlNkj9Ng4Y2p8KgImDDWF0fV59R6Ud8j0FciWIdjkxIXU748dBsFeHEn
         RjL5G5keP9lv9YeCAwJjMpLIcDR9kpogrruYw5e2DiowFqLQTKHQxRvEbNE6rUnmLNIU
         3BcyFrXEuvlAO5zW5inElCiRTPH8MKpGBDjXHDgz2hYaqETRjQq49Zy19Jlcor0XpW4Y
         9Hd6zzcMqiZch988GZ6RkBM+0BVHeqddEMdOoX3dTWujEAnYn2uzd+Gvn6Pp2rcerqVt
         f+NOI8NQMPvwzwRqcZQjRaPesQajJGqybK3CzHN9dVuZICD+JtqKZoUxQswKWJRQLx24
         sZuQ==
X-Gm-Message-State: AOJu0YxwDi+CnReNIvx6zc7bw+fc39+5Jub8hdO8CyjGjNtNy6f8SyHl
	JA4OnXFTjUhX23DBO5/hJ6jhIyGnyBz6wefrobrSWORhr3/ariypmgJZrrEQpV08yMY=
X-Gm-Gg: AeBDieswTK77H2ul8bbxlVXicZTk9hx9leE6T8ehVxVFtT6n9fYK9h9mE8WkT8wjix8
	upDgnvKwaxU31PWkSnMpwjdeMYWB/eOnfpepu4ha0bQjSJjuG82oi7dQA0QMYDiusp4pWSc3v3m
	i4/pWQtEoNHieWcG1j5ce+xoCl/SN3E6yUa5EV/qMbxu8TRqeNDGc/fOVm0HQ1Js12DhVRUFBL2
	a1Yl5HExKdHLQLytRh1BfgYJOer8F7B+/hJaZRDSbBrIVJQEUJK/UBDDNHDTIPQIPkwHEJwR6tF
	ObMZZWv2DyDArPnUYTcUGXbx1vwMipyzwxHFSyXlxWJieVV9m5UHBvDFFQg5fmYaQEselfknAo4
	CZNq3ZyX0fikgg/AnuQY742OyUh2yLIZBL3EWUnjGPrAxQLG7l66QRPHord/YeEQTlEZUOgO20g
	F8NeD7vhbSH9PSG6pd0oCFOY+CKSC9ysyvSWhHECM31+8srA==
X-Received: by 2002:a05:7022:427:b0:12b:ec15:69d2 with SMTP id a92af1059eb24-12dfd8622dcmr3295022c88.33.1777847702472;
        Sun, 03 May 2026 15:35:02 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df845e220sm14486687c88.15.2026.05.03.15.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 15:35:02 -0700 (PDT)
Date: Sun, 3 May 2026 15:34:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Petr Oros <poros@redhat.com>, David Ahern
 <dsahern@kernel.org>
Subject: Re: [PATCH iproute2-next v2 1/2] dpll: add ps unit to phase-related
 pin attributes
Message-ID: <20260503153459.388de695@phoenix.local>
In-Reply-To: <20260503151352.136509-2-ivecera@redhat.com>
References: <20260503151352.136509-1-ivecera@redhat.com>
	<20260503151352.136509-2-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 369A44B7AF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283688-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On Sun,  3 May 2026 17:13:51 +0200
Ivan Vecera <ivecera@redhat.com> wrote:

> +/* Phase offset - JSON prints raw sub-ps value, FP prints fractional ps */
> +#define DPLL_PR_PHASE_OFFSET(tb, attr_id)                                      \
> +	do {                                                                   \
> +		if (tb[attr_id]) {                                             \
> +			__s64 val = mnl_attr_get_sint(tb[attr_id]);            \
> +			lldiv_t d = lldiv(llabs(val),                          \
> +					  DPLL_PHASE_OFFSET_DIVIDER);	       \
> +			print_s64(PRINT_JSON, "phase-offset", NULL, val);      \
> +			print_string(PRINT_FP, NULL, " phase-offset %s",       \
> +				     val < 0 ? "-" : "");                      \
> +			print_s64(PRINT_FP, NULL, "%lld.", d.quot);            \
> +			print_s64(PRINT_FP, NULL, "%03lld ps", d.rem);         \
> +		}                                                              \
> +	} while (0)
> +
>  /* Gene

Any macro this big should be a function

