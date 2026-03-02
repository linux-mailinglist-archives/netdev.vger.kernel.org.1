Return-Path: <netdev+bounces-262651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHvoE7aNpWmoDgYAu9opvQ
	(envelope-from <netdev+bounces-262651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 14:16:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3AF1D99CA
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 14:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 09F8A3021B9E
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 13:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0543F3E0C7C;
	Mon,  2 Mar 2026 13:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="kP2OkOx1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276913E8C5C
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 13:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457347; cv=none; b=TmtZOT901B8vQN8jWZTv3xsWNmVBsgH9uJcu47oNYNplNacQI8UTOzoX19VA3Ve8ZRE4FwbxlVKwPxT7rGVl8ZMwqjdsirdy/bO3xR7oVO5XRQl3cV1yaUeSBNmla/tV1SJwtZxlnDhhQzKaNc+Cl6nOQgRxIt5ARfcilBdgvzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457347; c=relaxed/simple;
	bh=JV5gSZRhPiMnRwmWCCQiBvuE3NFV3+3iTTS8WPm+N7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mpd5GY+6Nc/o9uLOvwlchgXRmym4R9yPZAyO1BbtgzOoxPoER3mY7D8r04ScLu76OWdCt5EbFAc+IGQEAMaiuxZBsrTSPyREVGmq9AVQTwLpmeK04LTgUAe+YQBtZscH585K4Ymn/cJp7FYxFdeJR66gs6JMoUlgpeu2JbZLhAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=kP2OkOx1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso30836575e9.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 05:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772457339; x=1773062139; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DHkP/futS2zgWyQTyC5FXIesale6XSmEvAtzel8W+sM=;
        b=kP2OkOx1OGk8QzCJ6cnKlczbiViedPD27Ke1MImKIvKEN29UhPXB6cIS7krZpIPTg7
         UtmjFCmAQS32toy1Kky0VUYQ6nknRRVluwBbwXHw6cWEZNCVAgS5EELzDaqzeBLSo6Hl
         6MBO8HVZMvyD6PlHRN33vJ1DlYOmwGHcGRfuGiwe7PpC+cjWOvs5SOS4yXY3lDq7hvss
         zkaT8t/3Cam4w5r+FQXLTIz1sN4S7eEd1VX5QajWDFRjikohyMIelygNs2O2oH4ZYw0Z
         AUAaYJJMMI4yT+7+5mF04/q4qHGd5KDFQKS/68y4IqW0DIWdfkKgJUsDRnvSUoosIJpM
         kiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772457339; x=1773062139;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHkP/futS2zgWyQTyC5FXIesale6XSmEvAtzel8W+sM=;
        b=sjag/+unyWdGEvBuD+VshhL6tCSqAijy5pr4F/tsFBLoikB8KBDtJ6uPoiNhE9JNDk
         1Yv6R8XvF4QaFwFiiM03B2Jl9b0CReDDLHWRErv7uW73DuwDKBTi9Mmdk5o/nl18v3vW
         F9soqBdljJtXT/ijt5/eK1MXy5nS8mKdAqrnBpor4dHvPpUNqCdzyqGGlsh/hZIAuzPg
         I90cuYiH49jw3amXNMiG1jt5Trn+B4Bkd83o6h8mcz3Vz7mP7//y0QsVAyyEzHd6eYVM
         2/6/XrbgS1hZUSDxVa3ZKywZDRDUwrnyxJA8zSY8HcBCQNrVqIUyL7z0CZevSvawIl5y
         ndiA==
X-Gm-Message-State: AOJu0Yyzh053ifPHmCK4GtBUkvJpMNZyF3rDlYnarNNhZjZwrjpUTyUX
	gWMLkNL3iDEb7riBaSx6KyWwGY2TpqELPXrxpU/4XXjTCbmBcHrz471eLefNZ4na7FM=
X-Gm-Gg: ATEYQzz84O9Q9IfuFZ5Zaammd0dwLVgC4Gs6Fax8hXUr27YKiwI3hEEOuZe2tYxKIvp
	QAupQWtRotGrfzzEqGBO+f8LT2i6E/S2Z3Dq1sdAPXbQNduK5xW8lbF1ASVeOWwjH8I/Pnk7jbq
	EP6UFYjhOqckYgNJJ8CtZ0MGNQicDfC7i8+SwOVfXkTVuXFwzZaeaqg+yLoXAIQJ6Y7W9OouEpf
	936OhCdSuUQqCsEWp1/eeOkxnK+dpGLPPAXR3A5tNKHyw2o2fIEjm6BK8DS8EM1jYpbxkcoTolV
	ypwslVxc19RmE31YjltY95SIVZeo2kWhmFksliiZZqeYLsBqQxB1wbCZnu9yHcjZgMh+K/0ZupG
	Cw2/7PXFZAv9UKt8dQ9497WxTKHkz11Aeck0cH8v32bbITJbKP9tzy7nC/+QBMJwxytVAQWuSUV
	mtxymF3XdmYpSQnovjyxZfWClKWdNqORpSnxYQ54r7A4s=
X-Received: by 2002:a05:600c:a010:b0:480:4a90:1afd with SMTP id 5b1f17b1804b1-483c98dc373mr207220875e9.0.1772457339037;
        Mon, 02 Mar 2026 05:15:39 -0800 (PST)
Received: from FV6GYCPJ69 ([128.77.52.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b3d24dsm245616515e9.5.2026.03.02.05.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 05:15:37 -0800 (PST)
Date: Mon, 2 Mar 2026 14:15:30 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, donald.hunter@gmail.com, corbet@lwn.net, 
	skhan@linuxfoundation.org, saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, 
	mbloch@nvidia.com, przemyslaw.kitszel@intel.com, mschmidt@redhat.com, 
	andrew+netdev@lunn.ch, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, chuck.lever@oracle.com, matttbe@kernel.org, cjubran@nvidia.com, 
	daniel.zahka@gmail.com, linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 07/10] devlink: allow devlink instance
 allocation without a backing device
Message-ID: <lkotihkrjr44jguht3cbj4kozxykqdzqedm7rm4cxuilsy76s5@mtuhatnluxgh>
References: <20260225133422.290965-1-jiri@resnulli.us>
 <20260225133422.290965-8-jiri@resnulli.us>
 <20260228150138.14e35ee7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228150138.14e35ee7@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262651-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: CB3AF1D99CA
X-Rspamd-Action: no action

Sun, Mar 01, 2026 at 12:01:38AM +0100, kuba@kernel.org wrote:
>On Wed, 25 Feb 2026 14:34:19 +0100 Jiri Pirko wrote:
>> -	dev_warn(port->devlink->dev, "Type was not set for devlink port.");
>> +	if (port->devlink->dev)
>> +		dev_warn(port->devlink->dev,
>> +			 "Type was not set for devlink port.");
>
>since I'm already nit-picking - maybe we should have a helper for this
>case an pr_warn() the message if dev is NULL?

Okay

