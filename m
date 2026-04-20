Return-Path: <netdev+bounces-279892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4H69AVBq5mmBwAEAu9opvQ
	(envelope-from <netdev+bounces-279892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:02:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7F04326C6
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFDFE3009893
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 18:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D2B3AA1B8;
	Mon, 20 Apr 2026 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKlnEuSw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57603A963D
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708166; cv=none; b=PFIgC9jHXc2Gzqd2vsJxMaVDN2JLxI5XxCEvcmvh5+gLKeikzS34OBheDbA7P7QB6SAXM9XEThSeot4q7fFJ03tYOr7y1CokxwGnCOnAzd323pSECvnjG8pVzAkXi1H6HlFHRBrXIZ1wuDIi7NFxd3LvydRcIkam36MoOIJD+0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708166; c=relaxed/simple;
	bh=1l8v/fESj83GAnrDRzaGZx+a+AQ5uk+B6lt5KCjkDXY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=Sy5ZLpTr/INrz0A8dBM0SnB2nQzf9r2yQqQzymq2uOYkxaWCSJpHPBNtEcyUgMc2Y+R0S9TyCNx13/ejsg/rirGwi6E9bR1rLmp6E8nGa90rx30zcsBroIhjpk3iD9Z2sJpDDPsZketfiwUwVGFdxelPm8QYMzMuptd/8yqoxCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKlnEuSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DEAC19425
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 18:02:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776708166;
	bh=1l8v/fESj83GAnrDRzaGZx+a+AQ5uk+B6lt5KCjkDXY=;
	h=Date:From:To:Subject:From;
	b=oKlnEuSwLxZS+cGdPhKNFtvHEjb20iamQLiWC17P+5cTEHPI6qcvmKBCoaD9BeQqM
	 MUPBFeHJZl1UUhaUQJ8FxcvFs2SPw+3qI7A8Bz00VPNE1Zdlc3hs4OY9O8JBdmtV61
	 ovIY8i7xE+aM828ybGTnmBeXPkyTleQ+C/QkEQ6z94Z8QClODGhotJeLWmIQK6fO5F
	 3pdwoqTQc+UoF2XLklQAbLET8yH6Lb4g7z5ScOH4qu+U6qh6vKrgC5koxti0DjGMxj
	 3n8jgblTIfqYJ78q4I4mZDPn2rsKzdUUMafdVriJzR3hOZMOVz+bOSiT6PQTcSrxZQ
	 NyvpPCuPF779w==
Date: Mon, 20 Apr 2026 11:02:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] netdev call - Apr 21st
Message-ID: <20260420110245.239b0241@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	TAGGED_FROM(0.00)[bounces-279892-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lwn.net:url]
X-Rspamd-Queue-Id: BC7F04326C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi!

The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join

I'd like to discuss evolution of the process which would prepare
us for the "AI age" (read: influx of plausibly looking yet entirely
computer generated patches).

