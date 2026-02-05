Return-Path: <netdev+bounces-257035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEd5G3dQhGkE2gMAu9opvQ
	(envelope-from <netdev+bounces-257035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:10:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E5879EFC01
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 09:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F26630268A1
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 08:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261A135A95B;
	Thu,  5 Feb 2026 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gDVH4XyZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4128327BF5
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 08:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770278995; cv=none; b=G/Q43LDW0zaAV0Amm4pJEhO1d2rKx6uJk9Ay6PnKjV+IWDNGuQP+R4asWLMMf+ea4QScYQwQGCLKtJrE+/1J8JTwbhZQSAKzvpNG9eurlQLUD0quxK66VXwxCgQEjjGePNVDdAADdtUr7/JOyBeLcuW9WmQa6v+P1eQ3MZeHCZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770278995; c=relaxed/simple;
	bh=gzjhJm876283frA6S33u24yM/1DfsgTqaYPRCcVjPrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cNrjt6yTO8Fm2QUhvs4s2acWw5lF3bFQNxm6vj5xv7s93Q1clfYhYjoP/U/bAmfZto9O7waqPmtxz16iCnsRThGljf/0F8tKZVqwE5nn7wKWjWx+eIkcEuinXhRqyE6Js892b/C6ETnykw0v/+M5qLD7k9QDDhkt/5RvkFQ7+f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gDVH4XyZ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4801eb2c0a5so5249205e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 00:09:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770278993; x=1770883793; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3hanDd2YbvQ15Sy0DixMpocIzNH3MgOOyRQnrSACh/U=;
        b=gDVH4XyZAh9ElsPeqfI7cVPGA5THwkXvIti9VCVm/wPEKlTscTqCiewRg6uahdwT5m
         OJUqNvwF/oyVLxR9zXgHr7OlVye5v5Q5RSoFqSaNqOEtZmesXJHcQ3IM9W7YR+fCp+dE
         TH9+EFNP7j2xAGlYh4uuqCY5NWGCXnizHttw8Or1f+BqVM2B2odon2ptUdMO4AM+mQ1G
         9lZPlDAW59XrNHdWlkoEiGOk85wNH5MEbKofwTe5T17X0dufCceyZ/gCc8UVGpg4gARi
         kDCUkd7SZ3V351oc6MlncPWOqq9nTPBbXvr5cDDBTCj+iBXS6ja8i7+aGJF1b71SPX2F
         pbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770278993; x=1770883793;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hanDd2YbvQ15Sy0DixMpocIzNH3MgOOyRQnrSACh/U=;
        b=any1C6q0dl71JWx4iSkCEQPZj4iVB3r4ZsRqhR1l4k9YbD1eOUreWBENPAk0dAfvop
         M8Zk8DBeBNUEboOeHqJ9Z6X6q8Y3UVxfmYpVrqxIe8vkRQ3r4VDMHysDWi46san5EDof
         nck1Hl1EeGiAs3FnRBntQD8qXCDlanFFTC0+p5jk2PrFaTjB8UvtvqdkYLLuczvjq2k2
         bsaGbQUXZEyYOS4nRkxn37dGHdQUMCDaxxucN3pbH/anWj3CIBnoxfRdiq9VR+NRM3pr
         JDyKLCfpsCVVnI4VQL2LYeQGbZWtE6ZJTwC3HF0tJN42cAgM9r08RVoj29KCPHge+xLf
         Hyyw==
X-Forwarded-Encrypted: i=1; AJvYcCW8tGREmn2Gy/nruzR9tH5nB/N0gG+j2NRiICjJvVYggtSXJmjqlBngSZW+YNIqcCD+Jqhi+Fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YweQK2aVJqRSC4dtDrdmAOvMnpN1dmmAxD6KDV5MyXxGPunWn0Z
	uvl9eoLcmXLP4tn/B7+7pt2dj066OEZvrEgN7iYcBxcOvPw5wQjdg4NXOIbdnN6496E=
X-Gm-Gg: AZuq6aLH+Ix7mF8qniUVOcK6hS724sglj4EDGYjZ/Cec1PvjeUL8NyhOrml9A3MuDtK
	hdALhbC8IF4lkPqXA4iRCrvnoB83NB4KE8i+lYH+/c5oB0kM2Gk5M+DggHmn1wedHoDVp2q44n5
	nIQKNCWXAkfuNNhEyyWRcOA3i6fW4DvHynflZxqFujPpm+qxnatgabyo8oDLn8MnbapXf3v58ud
	oxkooUIlVmddZkIeSTc0T+QFmDx9XeQryf7Othd1p9Aqjaq6R4OrP0Y/aibDEQ6WWJqWmSpJTGZ
	M1NMJDBhHrp+efEfUukd5DpyIyBhcFyFqUj+gzDCuvhFzg3KKvJ53Fw/0SNDddlEsBq51xzrX5J
	gF10b3YLvc4RKAbuq6UvAoreZiMUlrD8f7nRQOYDrkfQeXbxi+aNqWOAKyIiga0QCyfZcLzGejU
	f0eC2VpV0gHYQBnw==
X-Received: by 2002:a05:600c:34c3:b0:47d:5e02:14e5 with SMTP id 5b1f17b1804b1-4830e9347f6mr70746215e9.5.1770278992895;
        Thu, 05 Feb 2026 00:09:52 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43617e250b2sm13408502f8f.8.2026.02.05.00.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 00:09:52 -0800 (PST)
Date: Thu, 5 Feb 2026 09:09:49 +0100
From: Petr Mladek <pmladek@suse.com>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	john.ogness@linutronix.de,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, asantostc@gmail.com, efault@gmx.de,
	gustavold@gmail.com, calvin@wbinvd.org, jv@jvosburgh.net,
	mpdesouza@suse.com, kernel-team@meta.com
Subject: Re: [PATCH net-next v6 1/4] printk: Add execution context (task
 name/CPU) to printk_info
Message-ID: <aYRQTdNrzqRwClpQ@pathway.suse.cz>
References: <20260203-nbcon-v6-0-985f3bdb3267@debian.org>
 <20260203-nbcon-v6-1-985f3bdb3267@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203-nbcon-v6-1-985f3bdb3267@debian.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,linuxfoundation.org,goodmis.org,chromium.org,linux-foundation.org,vger.kernel.org,gmail.com,gmx.de,wbinvd.org,jvosburgh.net,suse.com,meta.com];
	TAGGED_FROM(0.00)[bounces-257035-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[172.105.105.114:from];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmladek@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[176.114.240.130:received,100.90.174.1:received,209.85.128.46:received];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,suse.com:dkim]
X-Rspamd-Queue-Id: E5879EFC01
X-Rspamd-Action: no action

On Tue 2026-02-03 09:23:52, Breno Leitao wrote:
> Extend struct printk_info to include the task name, pid, and CPU
> number where printk messages originate. This information is captured
> at vprintk_store() time and propagated through printk_message to
> nbcon_write_context, making it available to nbcon console drivers.
> 
> This is useful for consoles like netconsole that want to include
> execution context in their output, allowing correlation of messages
> with specific tasks and CPUs regardless of where the console driver
> actually runs.
> 
> The feature is controlled by CONFIG_PRINTK_EXECUTION_CTX, which is
> automatically selected by CONFIG_NETCONSOLE_DYNAMIC. When disabled,
> the helper functions compile to no-ops with no overhead.
> 
> Suggested-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Petr Mladek <pmladek@suse.com>

This version version works as advertized. Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

But feel free to remove CONSOLE_HAS_EXECUTION_CTX completely
as suggested by John. It is true that it is not that useful
at the moment. And I am not sure if it would ever have any
good use.

Best Regards,
Petr

