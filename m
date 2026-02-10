Return-Path: <netdev+bounces-258144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UOicIJxzi2nFUQAAu9opvQ
	(envelope-from <netdev+bounces-258144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 19:06:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2827411E36F
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 19:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3611B300C02B
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 18:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A35138B7A4;
	Tue, 10 Feb 2026 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U9uK7OlJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9AEF4FA
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 18:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770746776; cv=none; b=BfAQvtsgp18aIpFqktZmAIpmgHX3OZQ3iZjsblGy+Y3kdyVg6UwZnYsnEhKYGDnRlkjJmGyVEjm7mm+JgoJflPSvuT5rLQ2+qMt85W+29kPPk7YZ/PRzrZW4APGrhm8tIciBRCkF3zOf68ntb5uHVjv2NRJFjyeiCx5dqacDsYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770746776; c=relaxed/simple;
	bh=YAl1kz+VwRttH+8e8JJSQ41O51aTnMyPn2QYglCXB2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rOfZHX3wdNWV6iF02CnLe2Pu6VZ4LzsZ3NSzESkBdWa2fDZhuPaYXrqlk4obM+XpjhZWvTuhiWWYwzLRFlklKh9A5H/PIsaeGx12ObObIbPNiQq9Q/in8DQT7sXdoYJXDTji+GK6cXTYbBp4b2W+8JU6MYc2pLPPodTfOsUKJh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U9uK7OlJ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-8c5386f1c9fso603526985a.1
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 10:06:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770746774; x=1771351574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VQrgfquaPzKySAFC0y5fUivrJ9+1Cj9LagzYm8Nz4oo=;
        b=U9uK7OlJQ57QQNyiPIPJwUnQNotUWJfHWHDz+b2lEAYcK8bEKHX/+p4OL0dPtoe6Zt
         VZohfLMifC2wJiFjKQg6/FgkmjkBLoYAVX2r9+yYAu33aZUAxvlmOgLTv0YHqyt7JUcg
         7OVqX47aE1sPl2iyzIwCpW22wyUuG0dAY7GCxObsCox5wRujyKcb9MStqbGpkm6VDPpZ
         wwKHIKOM7DTS5RVRLRMzK0srn+eiyDdCKcCptnrYQU1SxVSddy660lE6CiH2JqiCR+yX
         ZV/7pEymOIpA6KCZM62GtkYnBnpCa9DMALhsCTrr5IUNK9e8xXl4eNYgZ8aoWmkHz7BA
         afig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770746774; x=1771351574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VQrgfquaPzKySAFC0y5fUivrJ9+1Cj9LagzYm8Nz4oo=;
        b=ZQsdf12CNGaswkjXdH0QlxjFMy5oOkJvFcRVjyHCzPYpOlDtNpIq+jTSpFI7wOW7GB
         wvj6iVtDuF+O+2WOat7hAFllvLYZOGn/UcnWZdvTb31RCXsoU0QWxEUqdgDh0qtUnd7c
         35B9yQ+YpHeKrOw0ylXqzew9tTvTOtewA0YWmt/xLR43FZSQVLgU/ltuYlQlsWYWUtNr
         9LjHTuzFrIrX0+NpVxinnCNJpuSZoOJx3z1U2S+pxArK1Q1hCpEOhvGTWQrbfEC+BUW2
         bCGkOW7ImziqNsFRr/8uhcAGm1IU2zKlWuIzJBIpninkwSy683zlB9owxOYOt3df1+e1
         J+qw==
X-Forwarded-Encrypted: i=1; AJvYcCUqkdPbdUvH164AdtaB4kRpaXa6hDddfFVr5Z4dXrTLjdZsG6avCWKX/Zzxaga7wCxJ8qZ408s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXsLd4Zk2U2iHahoAvOFGtxEx1wA18LZdMBp9papR2P1+IBZ3V
	0mhMsp8CPphGNjghdtsjzN76o57UaIcfTND/cjEZTnd7S4iJEpVUqD29
X-Gm-Gg: AZuq6aKdSX4gjNKrfWgp9+M1bpGt/H0hsZiYCC4GXbWxyEDUgYk6zpUyTBNIUEtFY2v
	B+a16BrrLDfFkeWDVAxoH8p8J6dsBRwNV2DvW0Alqh0Nge+zLQo79dpoysYORxHbFPVC/UWJVAw
	a79bDg3EMRvkMTr+c5TDCDb+jenx20DI0J1tmn+0oooLgU+VAcvgAhwICMk2I7dLaX+E478CQFe
	zIws45sY6vW1bUXInJQCNvy7M6MEpinW6T0CCEjg95KDN0as9I6UbtmSwIFYco61rPEOl0vy9Xe
	H/jGV+K1M1EgIWHGUG7PCIiYubKNXMXujT5QzMVna3oRaPAPa2auXMpgE9pajzAzTJVQ7Bcb9FQ
	/nQPG1QvvsQkpYCxVfNQwsrESzXwyTJzJpkhw2t89NDWI2YT3tT/xUyhhdneQNVwrbuTg1ztz4O
	D7iU0tqE7WtsU3qeeqP1w+SzyxSzMmNZj+2xUVH0wnpay4Ou6DXCgr+rHO
X-Received: by 2002:a05:620a:29d3:b0:8b5:5a33:22d2 with SMTP id af79cd13be357-8cb28040ff9mr11986785a.46.1770746773592;
        Tue, 10 Feb 2026 10:06:13 -0800 (PST)
Received: from PF5YBGDS.localdomain ([163.114.130.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953c03eb1fsm104552496d6.33.2026.02.10.10.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 10:06:13 -0800 (PST)
Date: Tue, 10 Feb 2026 13:06:10 -0500
From: Mike Marciniszyn <mike.marciniszyn@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>, Lee Trager <lee@trager.us>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v12 3/5] eth fbnic: Add msix self test
Message-ID: <aYtzklT3p7lsnC1R@PF5YBGDS.localdomain>
References: <20260206154246.814-1-mike.marciniszyn@gmail.com>
 <20260206154246.814-4-mike.marciniszyn@gmail.com>
 <e806861b-acd4-4615-aada-577e0275bb5d@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e806861b-acd4-4615-aada-577e0275bb5d@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258144-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,armlinux.org.uk,intel.com,gmail.com,trager.us,linaro.org,kylinos.cn,fomichev.me,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2827411E36F
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 04:06:23PM +0100, Paolo Abeni wrote:
> On 2/6/26 4:42 PM, mike.marciniszyn@gmail.com wrote:
> > +/**
> > + * fbnic_msix_test - Verify behavior of NIC interrupts
> > + * @fbd: device to test
> > + *
> > + * This function is meant to test the global interrupt registers and the
> > + * PCIe IP MSI-X functionality. It essentially goes through and tests
> > + * test various combinations of the set, clear, and mask bits in order to
> > + * verify the behavior is as we expect it to be from the driver.
> > + *
> > + * Return: non-zero on failure.
> > + **/
> > +int fbnic_msix_test(struct fbnic_dev *fbd)
> > +{
> > +	struct pci_dev *pdev = to_pci_dev(fbd->dev);
> > +	struct fbnic_msix_test_data *test_data;
> > +	int result = 0;
> > +	u32 mask = 0;
> > +	int i;
> > +
> > +	/* Allocate bitmap and IRQ vector table */
> > +	test_data = kzalloc(sizeof(*test_data), GFP_KERNEL);
> > +
> > +	/* Result = 5 for memory allocation failure */
> > +	if (!test_data)
> > +		return 5;
>
> Instead of magic numbers you could define some macros, or simply return
> a boolean success/failures value (as the caller ignores the error code).
>
> /P
>

It is not ignored.

The returned u64 value for all the tests is assigned into a per
test array:

static int fbnic_ethtool_mbx_self_test(struct net_device *netdev, u64 *data)
{
        struct fbnic_net *fbn = netdev_priv(netdev);
        struct fbnic_dev *fbd = fbn->fbd;

        *data = fbnic_fw_mbx_self_test(fbd); <--- stored here

        return !!*data;
}

The rval could be a set of test specific define, but regardless, it is
meant to refer to a failure point in the test.

Mike

