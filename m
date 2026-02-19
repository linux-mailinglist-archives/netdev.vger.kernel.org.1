Return-Path: <netdev+bounces-259571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CfqMHtdl2mIxQIAu9opvQ
	(envelope-from <netdev+bounces-259571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:59:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 65509161D5E
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9CB7A301250D
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 18:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972112EBBA4;
	Thu, 19 Feb 2026 18:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB9rxrm9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6786A2E6116
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 18:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771527545; cv=none; b=dAvIRUwRs6HJKUjET3ESbtsPJPRbHkYTWGR+4jIwSfbZYQmOD2j0/cqGA7VEvS40dZVgI3myFm7lByfzVBmFpJim1bC/kpXwreMK8/nzEjZZ2ujw/jvXVpbByXwlxjHAuL+fUeLzLpyN1Mvr20SHYxXlxEXFCcmUKli7o+suEWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771527545; c=relaxed/simple;
	bh=KGEy4wvRakUrqPc26U7DgMZlqe/jrfz5W4cb7lR68eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFjJLBtB7CsqLxqokzdAUVFqmFOu9JTwog/exernzqkds2N59tY1UJUkHL+fGPpLi/gGNiuXCMvDwP6uUHyCPWi+2YMngUIoYI+aoFBmirebk+tHi5/Y6XS0nqQhuo5yqV3NRV5GrY0r8gJdAO1sVk0OCFAOaDgI9uLOh2uBfuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gB9rxrm9; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2ba94dbf739so1398932eec.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 10:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771527543; x=1772132343; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Qk+SWLUF/tk56/FvpVCj+3J2nKmtZ65ZA+/dHfAzgM=;
        b=gB9rxrm9NUtq1+WvQTjbA4eXSvOvhHm0aiarbpfNJyD/bDbNkY5c8Quxog0fQE98Z5
         vm8y8MsK4tcXtfY8x8kvUrHo6AgEMWGcePL4E3nDMqOnimmAzEU1CKWrrX+hQycsg//7
         m1o4o/jIE0g6xqnaB2WiYI0F8YUFHBVHPqpTh7MlVE1rZSEyRUNtV66DBXcMBRPyJaXG
         19p1iUbS4uYsD3wvjhvJSQufVgG7RjWM3mFA+WHIPOvnSTgtY0wC3TQ6xVAwgMZJpmki
         W3kNtufJLXqSbINJPdDxZjVXm21X4hyY+GMdHrZPlVUx/crvisA03FR1e7ZEYcMz32Ui
         AeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771527543; x=1772132343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Qk+SWLUF/tk56/FvpVCj+3J2nKmtZ65ZA+/dHfAzgM=;
        b=GbEmU1VlgRA7UzEmTDk6Iz9li4TJpyhNueJxxUBews/CwBKydjoesGgHxJFDNMDVfF
         GjHenqqKWYTA6Zrc/Gf7v4iaEPY0TPYBO5H+2DgW7CLpI+CWNoKioIHk1mj3Q84fsvnC
         5Ay0nBzx8jmfkgcwAzVJhYAH6/oHAIFHXMJHLRJP3b4IAos2Gp+XOji5gE55DVkMfOLT
         g4A6wLqpM4wCQAsKPV9+Q3d1ewJPnwiMz/4/GvlwaopAglhId0h2beM/U//0ERzScHxy
         ibUq0lkM5ikgcczLuQKhvgBKLRVQCQMzclAj+TrCa04I/ne1LtzQUWZS1wMu5HqyF0ew
         42eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaaG4hwmuFYGW2omzwV6TqMi6eV/iZjjSI4+SeJ81uMjOFtIuGmkOsJRwn7zXycep+QdmkcUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE2/4uTcqJaRH6cDgXbUmjTqrPg+RIGnghd0dChQw12uvLqXND
	NvjZYxNJElATMvuJu6WaMAbvV7hm3O8p07KOAq3pCZHnaKMWXUr8HKFpanke
X-Gm-Gg: AZuq6aID12aLzbGSbJaSqj5/UbkxBTdFVrP2xv4DQtX5hpNclQtKDkeOKj4fAW9F/ga
	CkO3Wa8dB+WRnpQN3KjhjIOCcKGp5nl3jkKIaVVkiZ65rYsqIxOqqdZIz+nNCoOdkwQLsV2ikVs
	Y+uAKWbI8nLZFclxyCF396S5lHjXAKSdaJSc56LdT+AEjexjGVQTlsAPfG0I+nerjcqabbwN6Wn
	DrlK/8dW0f3MY2DgpJZGYYaMPyFhWk2LiWkfxchP/dB8IU2qx0q4ClIwjVbS2XFji3btm8zHYxN
	GDnNZDVm60W7hwCL3FrL/mCrsVmCl1lGWvzAXs1Nm7Bsjg2LZ4r3iOGLrtT6iepyCL6O0FQAqcQ
	c/6xJVZkZH/+tAa3ieojeL8E+Qa2t2LRSUZNwTCiX3mWX3ut+NvNUNkUSD4eyzgbn2de4qoIAIu
	mW2gUNKua1KxxTgA36U11rKIfrf7OOMug1DhsZcdB0YHVlxlTO0Wb5L9XmJUUNfQFgtrpXny8cG
	QpzIfwILc2/Zcvwhg==
X-Received: by 2002:a05:7300:a44d:b0:2b0:4b5b:6820 with SMTP id 5a478bee46e88-2bd501490e5mr2231392eec.26.1771527542769;
        Thu, 19 Feb 2026 10:59:02 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb577c1csm24579715eec.13.2026.02.19.10.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 10:59:02 -0800 (PST)
Date: Thu, 19 Feb 2026 10:59:01 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+2b3391f44313b3983e91@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Willem de Bruijn <willemb@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: defer __dev_set_promiscuity() to avoid
 sleeping in atomic context
Message-ID: <aZdddVNRy6sYiUEt@mini-arch>
References: <20260214033859.43857-1-jiayuan.chen@linux.dev>
 <aZURjBHTHRvjP7Ee@mini-arch>
 <20260218174025.2fe593d3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260218174025.2fe593d3@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259571-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stfomichev@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,2b3391f44313b3983e91];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65509161D5E
X-Rspamd-Action: no action

On 02/18, Jakub Kicinski wrote:
> On Tue, 17 Feb 2026 17:10:36 -0800 Stanislav Fomichev wrote:
> > > Reproducer:
> > > 
> > >   ip link add dummy0 type dummy
> > >   ip link add team0 type team
> > >   ip link set dummy0 master team0
> > >   ip link set team0 up
> > >   ip link add bridge0 type bridge vlan_filtering 1
> > >   ip link set bridge0 up
> > >   ip link set team0 master bridge0
> > >   ip link add macsec0 link bridge0 type macsec
> > >   ip link set macsec0 up   # triggers the bug  
> > 
> > Can you add it as a selftest under selftests/drivers/net/team/?
> 
> Stan, this "fix" may work for the promisc flag but won't we have 
> the same problem with sync'ing the address list? Looks like team
> will do:
>  - team_set_rx_mode()
>    - dev_uc_sync_multiple()
>      - __dev_set_rx_mode(port->dev)
> so AFAICT we're calling ndo_set_rx_mode without holding the instance
> lock?

Not sure I understand your trace without more details about the hierarchy.
But you have a point, per netdevices.rst ndo_set_rx_mode is synchronized via
netif_addr_lock and we are breaking that with this patch.. :-(
(so I don't think we need an instance lock if we keep netif_addr_lock?)

For this particular issue, maybe we can do something similar to net_todo_list?
Instead of changing the promisc for !FLT under right here right now, move it
to the rtnl_unlock? Not sure how important the ordering is..

