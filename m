Return-Path: <netdev+bounces-261684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OERHKMDoWlVpQQAu9opvQ
	(envelope-from <netdev+bounces-261684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:38:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E985F1B218A
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 03:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D4F7302A044
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA8C290D81;
	Fri, 27 Feb 2026 02:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQEBe9gX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB221DE2C9
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 02:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772159904; cv=none; b=JANKdCfjSjeocoOBH8pCK1Z9GJWRAJWqn002jZ1yuv67dZG761q3KEsaqnUH+yLKXkbes4WOdyp/20gFR/TfeDDxgx2xQNlvj68ykBNbxx2lUxeeD1i1Cj8E0hKJUKwuLOBz3Jk08sp/awggWR7zXgEmlxaXISy5yrTyNAHeHbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772159904; c=relaxed/simple;
	bh=kp5y/dqejQzeVZ05Dw0tg7a0JpUUplp6YZ/04Ae9L9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqc4ePX0eTgZJ61EXV7XZ/I5fKFT5ulJsTreAT7p/cG+0t9r3PtVFxfxFnO/pueuM7xqQV1iyNW8QtVY2X6Fri8qqB2EhvDJBIg0Hb26eMVxM/9LjqKG3sbU0QxVctZawtV68QqJTsT9HUTw7NkYgXJbpZmbW2DZY4L/L0xZed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQEBe9gX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ad21f437eeso11507345ad.0
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 18:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772159903; x=1772764703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vKuElitLd5LW7g7YRPmlUwQxzRJLHGJrlc783qqUFmI=;
        b=SQEBe9gXI3/K0ivHn2jG0AHzu0UVM7bHa5EvgKr66FhPr6ok0+L5e9wAmZ8h5E7MP9
         kE84uAZnAJnhdtF9AkoszESbVPsvakAnMSrN6MCeggDD8bnbWjY49SfW0pE62KgKCupw
         oO2ThhEBhSy0x6UmasK1p7vJBjbWJiQRQeCgeFTiTGc7iqyCUVkE20Zs4nwp8oNLTgOT
         G3eoxPz7txq+0Lmy1RS1WoBK/lfQKaSnd9MkuMfhEHGvkNFKk9a9r8jDHAm+hyNarRMw
         gTdP1CJI8jCeTR4s62cOLY3Kd1xYXipu6ckRSv/hTl/t1iPCvc6k4VROAauuMn7o5+YF
         t18w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772159903; x=1772764703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKuElitLd5LW7g7YRPmlUwQxzRJLHGJrlc783qqUFmI=;
        b=jxX+t7+E0vM4L/qkXzLuSyyHFaxBs6qFwJNDnZJrcsCbz8/ZUu0limVbAdaeZm5DDw
         Oapwps6sD6OLlT8BFmOQG082Yg0IE5s1fOx2cjQN6/2tHsRwbnQ7Rdl4HQt7KygUg8IO
         VJh/V9E4UT02uEGh0c5SMPWJOqvHxwyuyyq++aegy+d/nPkmS53ERc3dY2/uBWKg5fyq
         QvVg4DythcvhpX+sd7bHzpfpYcuV9qots2VNPRDkdCwEoFCiZVcDdg/KCVaTFsGm3zGZ
         TEkYYw7Xr/6gYNckcr8KWZVsdoLVdJBa3Cfm6IROMdbOAboEdAqhsYLE8YjLOS6/F7DZ
         oUTA==
X-Gm-Message-State: AOJu0YyQkx23y1YnzVCAdT3iqHhXknrw+I3CAC5bLj94TXwWkuk9W5Km
	fIFcqM+fbWaq2z9GHZgfnooATyHcbbihl22lyVfKeGUsDsPmNkHYws69
X-Gm-Gg: ATEYQzw0e88eCmhMoOrGg2hbrTS3gZhGRJfQt1jPP2ES6vqdlPPwZXWc40iVZ0GauWv
	muEVdERDlHYGawO7MhFo7KSc55fD5GbQ1oDHrUh1dM/1Y9cN6wVIRhsKDOSDeRKIU7ZyiYdZgtm
	s6DHc29sIUni161jPn9hkGIsig7ven3legMt+Ym3K9z/2rGM12l3lsvHyXptpX5SKJtZFQF8a2Z
	xlEDVgQL0TS1CsHqngAsrH7zF3HL57ADPGhlhOGEjgZMjXYN1Y0xmQXLZa1iTRtntJrlwQ+fubO
	l9aLRcQ8qPMRzqdl9IanIAkrJfzf48ofID4oyoVDqEnarZzQtIS7EcQGbUkH91mMEdxQus2X76g
	m7RsAkrTo69QupNvWChivuzwGeXV4qwqfolEapiWVReDtgGwJ5E1WhyfV4sSA4OKrMv+Chqj6KD
	kqBu+lXgkfhVJTreHAE3c2zuq5J9i9hUdBiBl4xuTFl3MwfqEM9/vjc+/COOpI
X-Received: by 2002:a17:902:d589:b0:2aa:d288:851e with SMTP id d9443c01a7336-2adf79834ddmr39869965ad.19.1772159903149;
        Thu, 26 Feb 2026 18:38:23 -0800 (PST)
Received: from eric-acer (36-225-69-192.dynamic-ip.hinet.net. [36.225.69.192])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb705b53sm39057515ad.92.2026.02.26.18.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 18:38:22 -0800 (PST)
Date: Fri, 27 Feb 2026 10:38:19 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com,
	mbloch@nvidia.com, jserv@ccns.ncku.edu.tw, charlie910417@gmail.com
Subject: Re: [PATCH 1/1] net/mlx5/core: Allocate ttc_params on heap
Message-ID: <aaEDm7_f1GpfaM4T@eric-acer>
References: <20260226092857.1583984-1-yphbchou0911@gmail.com>
 <20260226092857.1583984-2-yphbchou0911@gmail.com>
 <aaCN17Xsg9qVM6UX@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaCN17Xsg9qVM6UX@horms.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261684-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,ccns.ncku.edu.tw,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yphbchou0911@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E985F1B218A
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 06:15:51PM +0000, Simon Horman wrote:
> 
> Please use tabs (8 characters wide) rather than spaces
> for indentation throughout this patch.
> 
> --

Thanks for the review. This issue has been addressed in v3:
https://lore.kernel.org/all/20260226174601.2120282-1-yphbchou0911@gmail.com/

Thanks,
Cheng-Yang

