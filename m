Return-Path: <netdev+bounces-275896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KD1ZKK+91GmWwwcAu9opvQ
	(envelope-from <netdev+bounces-275896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:17:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFF63AB338
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 10:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E3003022F98
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 08:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B644398910;
	Tue,  7 Apr 2026 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="jU7wIyar"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E725397E83
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 08:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549817; cv=none; b=lYrC4nTDMZ73/oxiSVn/L/UhwE8S+LI0t6yduRQ5C8RHWkZod33bxDsns8qddMn0ZsU/bF8BLxcir/2/1c77pgtnmt22VsFduHXgxuf6naUiQPQV9pbxZ2chaCxoOlMHXy+Gx8Jpu7CICXk8X5qqrCJrpNMPkXgpwZndVeZOrYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549817; c=relaxed/simple;
	bh=xWkZ6UuY/bnFtNyk1/CdyaKVe6/IpgrXc8ambRBSbRE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dqg7dWF6JezEU8GERU0GNMAH06Pw06VIRgZQWLiidlWbkWTnB/ForffESJ1PBFTPD9ngb04Pg9lCZhOPHMK+8rLTjjmIwvOSkjOC9nvVNk3qMzE26EKDkkN+IFAfVHQD0BRGWaMMjTQ1kS4rmRjN6kHI7VPLY9XlANz7nWVHIi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=jU7wIyar; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id B601620190;
	Tue,  7 Apr 2026 10:16:53 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vzLqlPlmTEFl; Tue,  7 Apr 2026 10:16:53 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 1FD152068C;
	Tue,  7 Apr 2026 10:16:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 1FD152068C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1775549813;
	bh=6NmR0MOr52+deTL8f5g9SQNTAXGEjfl4f6UR3uVaHfY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=jU7wIyarZify38bavbfb8sMOfgryvUCQEfOSmShoxVPkC66kC9m99eh5vJgiVMqQE
	 PsrpnWH6by+ZB8fymH0O3vMIn/Me0jdvA4IOUf1S7nGPNk22ODpwDm/oIjSr4W+N01
	 F9Yy/Dgkd1EosI1rFQcK+C/97GLXm1kaUbSZbJmzRRouk46Sw5jlHqCv9be+CZAaCE
	 eMPfu6oUk3RKhnvrftfrss4eetGnUr2+jqAMxYpa0DXqGSw05JX+uajqRXA+p4zpk+
	 Xt7zcJ2LqbOkhWLIvudPAuaxed2Mt/7+Z+AGoGMKwFqYuLVgn0zs3aejTVucxbENKT
	 VFQe7Rn3ToGaA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 10:16:52 +0200
Received: (nullmailer pid 1489223 invoked by uid 1000);
	Tue, 07 Apr 2026 08:16:52 -0000
Date: Tue, 7 Apr 2026 10:16:52 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Florian Westphal <fw@strlen.de>
CC: <netdev@vger.kernel.org>
Subject: Re: [PATCH ipsec 1/2] xfrm: Wait for RCU readers during policy netns
 exit
Message-ID: <adS9dNSsPmjgyh9s@secunet.com>
References: <ac5TePdKtegtWiRG@secunet.com>
 <ac5YaN5EJQwokOq6@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ac5YaN5EJQwokOq6@strlen.de>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email];
	TAGGED_FROM(0.00)[bounces-275896-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[secunet.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DCFF63AB338
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 01:52:08PM +0200, Florian Westphal wrote:
> Steffen Klassert <steffen.klassert@secunet.com> wrote:
> > xfrm_policy_fini() frees the policy_bydst hash tables after flushing the
> > policy work items and deleting all policies, but it does not wait for
> > concurrent RCU readers to leave their read-side critical sections first.
> > 
> > The policy_bydst tables are published via rcu_assign_pointer() and are
> > looked up through rcu_dereference_check(), so netns teardown must also
> > wait for an RCU grace period before freeing the table memory.
> > 
> > Fix this by adding synchronize_rcu() before freeing the policy hash tables.
> > 
> > Fixes: e1e551bc5630 ("xfrm: policy: prepare policy_bydst hash for rcu lookups")
> 
> Reviewed-by: Florian Westphal <fw@strlen.de>

This is now applied to the ipsec tree.

