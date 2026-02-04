Return-Path: <netdev+bounces-256515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDp1BhutgmliYAMAu9opvQ
	(envelope-from <netdev+bounces-256515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:21:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A2EE0C4F
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 03:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 990D6304A665
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 02:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE75274B28;
	Wed,  4 Feb 2026 02:21:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F414F27467F
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770171660; cv=none; b=Cj6uF5tYjepEDlDLKjxlanRdrQesOp0sQjL1HouvYXd+bhMB9DWjUczvlEg41yflHhCR/pdVFjmVmtBJ1NalwQ+0FXRf9tisTrs5sJLhTAMcj1VyZmlzpxx/7U3S5Ly+kH+q2K2RM/IH87MXEcjFkOj8FYkZ56fhzwPXyvyvkgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770171660; c=relaxed/simple;
	bh=WVMYD2FyPlM5YtpTPd71r/vJBQ+OyMIe1XPNGqbgxH0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=FfRZ1/0rkMQmqmpQtmX3XxnHbcULEHN/NCRf9EL3DTOjV5e3ze6oXTqrx8UTIdZseMpRAmygHYQzSEYljDVRYG2C7OxoQkoz0AQFMzm4aGFo1lKq8t+nV1oeyX3lG7xnMqqYqIHk4W9fwTGvahoFI5nD05iv6tWTnJmZHUgGwWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas4t1770171601t644t01853
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.20.47.234])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 14035160928567093879
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>,
	<netdev@vger.kernel.org>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	"'Simon Horman'" <horms@kernel.org>,
	"'Mengyuan Lou'" <mengyuanlou@net-swift.com>
References: <20260203075759.5852-1-jiawenwu@trustnetic.com> <20260203075759.5852-3-jiawenwu@trustnetic.com> <4ddc6f7d-ee6f-48a9-857f-a10448815675@lunn.ch>
In-Reply-To: <4ddc6f7d-ee6f-48a9-857f-a10448815675@lunn.ch>
Subject: RE: [PATCH net-next v1 2/7] net: ngbe: improve the reset flow
Date: Wed, 4 Feb 2026 10:20:00 +0800
Message-ID: <06f101dc957c$c3cd5790$4b6806b0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJleOpPEsmr23hemQ93knTonzMr0QK1kj3SAhOe/zy0OboOwA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MKgL46cVMGh4rBeRIwYq0m06ucERE4BpEld2e99JWtrQeg2sCvwdCNL8
	SMJ2xvzZpM4CmFZOVydGsPgWb5WnmETr0Rp0RdgwGUbNP+Mf29jzzTeALiqHgK8PY1Dilab
	ysYqc3IbHc3otcJWQ06Q8bSHNM73LKqnPhN8bFv5UH4qDDwNxZmpiMlGrmJ3Zz+hni/shOY
	TXEg6i0RnArY3i+v1iX2Yy1EjKvho63oRGHka74aM8sMDHvW0AKXQTPyVHw2zsa7hc//8Q9
	85c8oe3+MQb5Vp7VBAVm6VjwyHsQ97LAGNtf4AEMvxdyd6OUhKwmAbbIud4tQid/sJxe7l8
	55cOKOrhHcZfZIGKP3ppGV5KaQW5VYYNvmXvvIje1jELDxUXH6udNbAjxCpMJyqSWCWjgx2
	BBkb5uUTGQAUGgkHChDW+y9e0H4sQQH3eXiR+N4mYxWZc6EesZ6EXGRSZDbK912F+jBus1P
	LG8oTLjLwjVvBnec3dL/4F/Ah0wWTsYsROhehQZwOmiEsVXgl+qHkoDGLJ2nqA5xFKuPsJ4
	k2BuAllNcl3niDUZDF6NKGn6TpOfpatN//Vu9F9zrROB54Dp4jzo76gmYiqZWR35UUklQ2x
	kYleUVm7hVMAiUPPoWa8IW0KmZfXjQvOp/O2lPzOLXDCaXKvSxt68lE/TdaxkRSrm/7QqKh
	lGzPn/MW3vqFXE6RykkLPbDv2WufoZfT6h7q0v517yy+iWVk0j0kvm3iyRUrb3+Z0t/kody
	SRznTkKYixQXjdvWQlRH02W4jgDqTd3iSFkNY6S9rPbz/4bMuZhvXSMW3s+lLqMbf8XyfFl
	tOe55pzNOt8C38MpAXGYpxCc/k3EkxnZsGshHos6LbYIve0NZXpHXeLrfNEzmxsqu42ymmK
	tuzKkUKMI0rHQNEOmkp7gsAv1nJeLj55exdp4utuMLN+TGwaWnQK8Ny7QXGASF86r4TsXdG
	2FSkmzo+U58zHTjfGObRmQuYANpzYLcQ9cKg9tgDRPdfMlrQMthMkmwl04IwBVV2G3qn6A8
	XCxCw78o2DA/8Wr9k8DWNLEvrsK0MzhReSJm+Qb8N9q2rbt0xdhpMf07ou0HM=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	FROM_EXCESS_BASE64(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256515-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[trustnetic.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.983];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,trustnetic.com:mid]
X-Rspamd-Queue-Id: 73A2EE0C4F
X-Rspamd-Action: no action

On Tue, Feb 3, 2026 9:56 PM, Andrew Lunn wrote:
> >  static void ngbe_reset(struct wx *wx)
> >  {
> > +	int err;
> > +
> > +	err = ngbe_reset_hw(wx);
> > +	if (err != 0)
> 
> The != 0 is a bit odd. It looks like rest of the driver uses if (err)
> 
> > +		wx_err(wx, "Hardware Error: %d\n", err);
> 
> I also wounder if this should be fatal? Should ngbe_reset() be made an
> int function so the error code can be returned?

The error returned by ngbe_reset_hw() indicates that there is a hardware
issue, and the recovery process will be handled in another work queue.
We hope that the driver can continue to complete the remaining software
reset.


