Return-Path: <netdev+bounces-276037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAnEFaEf1Wnr0wcAu9opvQ
	(envelope-from <netdev+bounces-276037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:15:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 012A93B0C5D
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49650308B5BD
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C91361DBC;
	Tue,  7 Apr 2026 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHVZkKCv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845F83612FB;
	Tue,  7 Apr 2026 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775574526; cv=none; b=X7oXG2BavRO2qML4FqcK+/t+PRiSkUGF6fwaiBDttW8jyS2phH1jeRzTkHyiOXHt9QSw++iyN1yQtNT7wAgmvqHGtE1x+cFvHS/ywHXNlvMVxfvMFKEmaDdKGVZ6YdrjBlN8VPYAJTf3dNnYxkH9dMI/hk+P2srdARGeejjIFNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775574526; c=relaxed/simple;
	bh=q/NVy9HGOjeG5K5MygsEupZi81XULJyszHGOqtuQGuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QsPdPxptIjNCm2+9WqqDiWmNUWKsZtd8BqmXn4bLjOD5ROwpMjqn3+dp5SqaUPRDjcnMuCarC7uoD816iBUaV2mtZKYKm4PO5JUak4oaBMNUUWBazY0bw9KLxKRvsxWeH9BhS9nwr4GrUCeLdl5SFj/y6+92AMEQQLTBDTpL7xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHVZkKCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FDCC116C6;
	Tue,  7 Apr 2026 15:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775574526;
	bh=q/NVy9HGOjeG5K5MygsEupZi81XULJyszHGOqtuQGuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YHVZkKCvRC7vh6wajHfTyqqLTAnTefH90+KJu0K9kLDxvFj8nLr+MzrRqeTTObRz1
	 M0+9Yogrl0pQ4xFYg0xCGDMv77wQXLp1zAKjfqwRZcaP/iV4P34UXKOBZdwdQxSuH8
	 4rSHva/q60CoPODwPZp1GyMz2xmih3EI5AFgKqlM7MbfC0JwisOIQkWQ8ejiC25WiP
	 uM2z/5Mmx7M5dWFQ24ZkV5N5y0Kr0DR8rXzydZf2mj0uU/Es6yqr9tNrgBfdY94B+p
	 lOcA3oGqC+dyem0d+Ghl9VNoejDFjaGHT6CNq0PBOa8I1P5IBZdylMPZETRAOPKq5F
	 OW436LOZpWF8g==
Date: Tue, 7 Apr 2026 08:08:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Xu Du <xudu@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC net-next 2/4] selftests: drv-net: tso: add helpers for
 double tunneling GSO
Message-ID: <20260407080844.35368eaa@kernel.org>
In-Reply-To: <b65f95793e03c1cb3ed3af4e1b2bee89fcf7e648.1775527362.git.xudu@redhat.com>
References: <cover.1775527362.git.xudu@redhat.com>
	<b65f95793e03c1cb3ed3af4e1b2bee89fcf7e648.1775527362.git.xudu@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-276037-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 012A93B0C5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue,  7 Apr 2026 10:45:09 +0800 Xu Du wrote:
> As the YNL Python module cannot be invoked across different devices or
> environments directly in its current form, the helper abstracts the
> YNL CLI calls to ensure proper configuration of the tunneling device
> features.

Can you explain more? Why can't you use class RtnlFamily?

