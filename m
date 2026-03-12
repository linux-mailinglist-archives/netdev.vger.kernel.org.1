Return-Path: <netdev+bounces-266886-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKIwKP0vsmmzJQAAu9opvQ
	(envelope-from <netdev+bounces-266886-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:16:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CD326CB6A
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 04:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48952303A851
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 03:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5F7384241;
	Thu, 12 Mar 2026 03:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afyqvI9C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2AE382F3C;
	Thu, 12 Mar 2026 03:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773285138; cv=none; b=PWo2ggSc31uBw5ISbv0rVou/lkqyR7OTj0n8RFn7yNxdzEVuwWykx3VEAy5g/1hEHGoQLoxFZBtO7hU60d9cCY7A+MytBvy45lxVoUGVQLBn+hIQQ1juqQBVvqZBzRkCbpDjkUeoMun8bEINKtpNo8WlmCakfReMI+fOv29rhY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773285138; c=relaxed/simple;
	bh=EFLbjbJcITw1xaXcf4Ug0qEJcFUrHhcJHdDsPh+g/iI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fq84yc9mViIVFr3FCzyu7HRjbEaZ2JDRnE8LrYuHCsYoIQRcotu+gIhLiHwvqhQKbp7Y+oAiqKTu0UnD1uN1AmaBW6D1+VSmkmk5KSwNQ61jShdPANoiETsAdP8u7ow7oSkbgChs4AuONYmVdQr45rGLScrrArYTunZO8pz1/sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afyqvI9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73173C4CEF7;
	Thu, 12 Mar 2026 03:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773285138;
	bh=EFLbjbJcITw1xaXcf4Ug0qEJcFUrHhcJHdDsPh+g/iI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=afyqvI9CJ6kv0w1WBLShr8R1Pxg1jr9GDgxTOtNWf0yJquCdGhzMVEXcJVUUfac9p
	 vr00QKUvPiP3OvqhIlD8in5cZKs6+A3qgT/id7icuq7iD6kvyC40zdrHRkMF+w+t+b
	 By1LgHC7nCZOntk8d+f9pay58ewEhOAleLD2HInqc3CUpkJnEw6wrNSkXNQj7V/YJ0
	 KPOqFnK58FfE8QtXJsV6e6LYwlF8IX31Hsduef1OEONrknh+iu7dkz3IAEdiWh+1KR
	 5+11QVw9JLGwjVPyunGqBeArRmJPbqFjNyBCSRNqZuEJLA0LioVAb5Hq4tJyKwSHgT
	 aDJ+cNLdWbTqw==
Date: Wed, 11 Mar 2026 20:12:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Aaron Conole
 <aconole@redhat.com>, Ilya Maximets <imaximet@redhat.com>, Eelco Chaudron
 <echaudro@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, dev@openvswitch.org
Subject: Re: [PATCH net v4 3/5] selftests: net: rename pmtu.sh to
 pmtu-test.sh
Message-ID: <20260311201216.2b42fb5e@kernel.org>
In-Reply-To: <20260311201057.049950d1@kernel.org>
References: <20260309152013.565216-1-aleksey.oladko@virtuozzo.com>
	<20260309152013.565216-4-aleksey.oladko@virtuozzo.com>
	<20260311201057.049950d1@kernel.org>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266886-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pmtu-test.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pmtu.sh:url]
X-Rspamd-Queue-Id: 36CD326CB6A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 11 Mar 2026 20:10:57 -0700 Jakub Kicinski wrote:
> On Mon,  9 Mar 2026 15:20:11 +0000 Aleksei Oladko wrote:
> > Rename the pmtu.sh test script to pmtu-test.sh. No functional
> > changes are made, only the file name is updated.  
> 
> Please try to fix the test ?

BTW IIRC there's a way to make the runner run every test in a new netns.
But personally I'm not sure whether that should free us from making the
tests not break the host, probably not..

