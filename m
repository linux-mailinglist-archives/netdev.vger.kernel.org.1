Return-Path: <netdev+bounces-288784-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM7+LpBBCmocyQQAu9opvQ
	(envelope-from <netdev+bounces-288784-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 00:30:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2FA35642D5
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 00:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 26C893001846
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 22:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165E73D5239;
	Sun, 17 May 2026 22:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="tvdHKwzG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B52B3D5234
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 22:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779057035; cv=none; b=k6c4u4qpxgSAIXdYaa+YZwent8bpDNqHLYDCurPb4V82/Ie/c37CdxRF6/oOSepcx6PDpx+ffK9RoCK51f5hqEvd3oeLS0Y3387pvQz+R+eipgQRDrIcN240Jm8gL1RzIwLP95WNVRzf8Z/UvCHYuQ/gg8aGWMvFbrWIMHcgiBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779057035; c=relaxed/simple;
	bh=tFC1Tbig5ZrVoDzs4ZGIr+cH/i6Rgd6IXMeuXberw0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXcrW7MBadXwldry+S5TppMB51RA8x6oF4QpnKq2nKXAKq66T+OSPtHBxvBCrkvNZJfiNug/uKQP3VJUJPdEpHU3ps84xARi2vgJGZZStgkUkCrNOqeOzP4/HUSW8FzHfCAGvGGqh2IvN12+TGZfVtlraC0ePxi8bq+Y39jKk3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=tvdHKwzG; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1357c851a48so695697c88.1
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 15:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779057032; x=1779661832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFjN/px4t2GB4LUmB5H4/ZYU1cMD3YdG5kZ78HR4kE0=;
        b=tvdHKwzGRW8gCzjhN4hGxvHoG+qOglnEFvAyK9SwHYbSiVFMiISIvtnbzhCv5YMy20
         7Gb/ql0ew/MOhDO8ID+vNuAKUq7W9XsBiaFtPHIAFlL442kiRACd61/cbyCSJvwkMpAX
         lSPK3ZotHeiz16relwcQYE3KBap7nLPwCR1o6/S/a2IrrEdiMbCQvJ4kinQlyT0mv8U0
         mY5jMbgYJCVYyZaNzZ+AtzCSXhwK2a1Vs2IooufNwwmdoYRCY890r2CXIEOEru7Fc4Pu
         E6dPLqJNLXKhrfX6R81xvuJBIC/5eauQ3NgiWGbotmmVIQSPf9PTZZ9qvrHHkcsJ/p9B
         gOXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779057032; x=1779661832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TFjN/px4t2GB4LUmB5H4/ZYU1cMD3YdG5kZ78HR4kE0=;
        b=KxcEOFKQE4zL9wwXzziJDIErBypt/oc2DbFnXaBL652iyE1VKmIH4A0yBh/H7hmXMW
         /AYw+E/2q7yzrxuUQ/+JpcGHa/E6QuUHHbhWN3mQpesAzLK7ylYo8xwoPdaNvqtgKk+E
         Q0mrPnaaVgRBDxgsQMyDvwbAezlQA/7nr2+iXySz2OWUzfsvS4jB/ZYQFdlGGuImki9W
         8GoNnxCF2AVBR9+ouRS8mYd8zY8icfsz/Iu+l6hjk4yj5HB0QDDP/4uzYfO5m/QWhbj7
         UYBwI6cRETsbhACMmqKezAC7m2b41wVuLf2YWMNcdRMDdGaYJ8erULzqY5Yhao0NIJ8m
         iKHw==
X-Gm-Message-State: AOJu0Yz+P8IYmNG4ENtiDI9S5JPXiwNT9UR+sB5q0oYWq74wFbpJg/4h
	BJVdkBXmlyJbhovX6FXzqF4BXdpGV9YgBkeJacQ6eZkMOelogiU28r56RECcBOdDedY=
X-Gm-Gg: Acq92OF6M5rA13D6hY5MR3BNgU4eQwgCRT+WvNNcjQj0AsLIu+r8n7BB0v1LQH1Vj5u
	IB+6R8ueja3NYBaNmzg6aMDc/AZJTQgcM+Pbjdc5OVYk0S9DSoLjaQcy8nreYnd1xG7Y/H4moTZ
	OrUgGE1JN3wSJM8sPvYnK0XuJGvSp3gvTEFSKAC1E3kEIGSb6t9nCd5AnwqGpMvcMQg4wquXH8b
	PSOHvIk4B7Lf0mlwZNgDPD7LdxmtpI3cdZnlUuZajPL47ZI0rdXxx4awmGgHHz1srYKA/yfZpso
	BGwrESztaUD0nJyR7Wu9ZQEUzHSo4MeNrBsViBbBmUBVOpHQADGNpu3/OLfRO2mMuB2V2vcTFOt
	T87bZvgGXJMeQO1ZICNLBqhRoYWINMDagosMMM5EE3k1xEIcZV7ybbeNET4rJP9OkzyRE0Vh+rL
	4PiZXflwdGheRMcqfSvFifOD54RtXtq+jfeN4=
X-Received: by 2002:a05:7022:388a:b0:128:d967:4673 with SMTP id a92af1059eb24-13504515161mr5169307c88.16.1779057031968;
        Sun, 17 May 2026 15:30:31 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cf44668asm15091738c88.6.2026.05.17.15.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 15:30:31 -0700 (PDT)
Date: Sun, 17 May 2026 15:30:29 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: William Gonzalez <gonzalez.williamalexander1@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] bridge: vlan: reject reserved VLAN ID 4095
Message-ID: <20260517153029.1500c5a7@phoenix.local>
In-Reply-To: <20260511012339.71569-1-gonzalez.williamalexander1@gmail.com>
References: <20260511012339.71569-1-gonzalez.williamalexander1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A2FA35642D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-288784-lists,netdev=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On Sun, 10 May 2026 21:23:39 -0400
William Gonzalez <gonzalez.williamalexander1@gmail.com> wrote:

> The bridge vlan parser currently rejects VLAN IDs greater than or
> equal to 4096, which still allows VLAN ID 4095. VLAN ID 4095 is
> reserved and should not be accepted as a configurable VLAN ID.
> 
> Tighten userspace validation to accept only VLAN IDs in the range
> 1..4094.
> 
> Signed-off-by: William Gonzalez <gonzalez.williamalexander1@gmail.com>
> ---

Overall looks ok, but you missed the case of vlan range.

If you have chance get rid of the use of atoi() here since that
doesn't handle garbage input well. Instead using get_u16() from utils.c
here instead. Better yet make the get_vlan() a helper in utils.c
and even get_vlan_range() a helper. Other code does bad job of reading
vlans.

