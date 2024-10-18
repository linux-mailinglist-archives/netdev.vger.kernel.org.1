Return-Path: <netdev+bounces-136911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D01B9A39A3
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 11:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433501C2139B
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 09:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBD01E105D;
	Fri, 18 Oct 2024 09:14:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6111E0B9A
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.139.111.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729242841; cv=none; b=l5MJGAr58UngCTDn3QVL+tNq2AGMUqhjCpmFzR1hdjJtMod3U5UJrNIdABFhUkTrtlm26tCAFGCG2snUT80VQiFnxP2F4jyQUDZiahuP3WQ04b/v81Rbexkz10jRLfz6zh/sX75ToqUS8n8JnMxGzyEshrl9mqyBgapfmeRPbDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729242841; c=relaxed/simple;
	bh=inVU4dG3fTX/R20n0uIiKB5x0WUNokqg6yeO8w9PEwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=n3Ry10iY2PlIvckfVvT5YR2cY1hHNo3bsox31Z+75pUjxAhmxVUfu6xryEl6DBtoft5dxtL6GlxsYidTFHCXtPAKUxty1Nw6BlgAwJg8ZvBtql44kodLDwZmLDXmQUuQD9xL42RbV6evfxim/nAFsKfllMSQD1PRNo/DEJAfToM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=none smtp.mailfrom=queasysnail.net; arc=none smtp.client-ip=205.139.111.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=queasysnail.net
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-ZmxhOMlZNOa-udqcvQQr-g-1; Fri,
 18 Oct 2024 05:13:48 -0400
X-MC-Unique: ZmxhOMlZNOa-udqcvQQr-g-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C8D91956089;
	Fri, 18 Oct 2024 09:13:46 +0000 (UTC)
Received: from hog (unknown [10.39.192.7])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11CE119560A2;
	Fri, 18 Oct 2024 09:13:44 +0000 (UTC)
Date: Fri, 18 Oct 2024 11:13:42 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Ales Nezbeda <anezbeda@redhat.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next v2] netdevsim: macsec: pad u64 to correct length
 in logs
Message-ID: <ZxImxuVhz6LjOVSs@hog>
References: <20241017131933.136971-1-anezbeda@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241017131933.136971-1-anezbeda@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: queasysnail.net
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

2024-10-17, 15:19:33 +0200, Ales Nezbeda wrote:
> Commit 02b34d03a24b ("netdevsim: add dummy macsec offload") pads u64
> number to 8 characters using "%08llx" format specifier.
>=20
> Changing format specifier to "%016llx" ensures that no matter the value
> the representation of number in log is always the same length.
>=20
> Before this patch, entry in log for value '1' would say:
>     removing SecY with SCI 00000001 at index 2
> After this patch is applied, entry in log will say:
>     removing SecY with SCI 0000000000000001 at index 2
>=20
> Signed-off-by: Ales Nezbeda <anezbeda@redhat.com>
> ---
> v2
>   - Remove fixes tag and post against net-next
>   - v1 ref: https://lore.kernel.org/netdev/20241015110943.94217-1-anezbed=
a@redhat.com/
> ---
>  drivers/net/netdevsim/macsec.c | 56 +++++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 28 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

Thanks Ales.

--=20
Sabrina


