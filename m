Return-Path: <netdev+bounces-181462-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0551A8513D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 03:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 127428C68EE
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 01:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD3227702F;
	Fri, 11 Apr 2025 01:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lB664Kb6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6049270EB9
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 01:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744334904; cv=none; b=l/rAP9H4uzdm0ycj7MPZBDqwVgx99Uv68kUnaz+OM+p0AhHqZJKcBPmSNGGKGuCrA5ngsN7SeW5mLcHjj146gJROx29eXNd6D6LOcC2ghOTJEHKWBPBhvKiAfEg/X4k/pn1H/Ndv7KGOscUgYEzBb7mm/C7+aRBMU7HW8JcAWNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744334904; c=relaxed/simple;
	bh=bKgTzteQgd/rqmkVCqc5FDR0rQ6PgNyAEnBdPq6NfTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CjbSk5BsPiqLNpiKSbCe7IlOUe5UydrGsBq4VHGfsYMP0BvA2YnWiehe2n5x0v2AUelGYR8at4B/1YDHA8AqSEl4cIB8zYrmbpPoQfq5+qsG438munKD92+E5N6jBi6XCp6VraFZK2dNc739CY2Q7N58aJW/W2BHs5vzXOVjd88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lB664Kb6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B4FC4CEDD;
	Fri, 11 Apr 2025 01:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744334904;
	bh=bKgTzteQgd/rqmkVCqc5FDR0rQ6PgNyAEnBdPq6NfTQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lB664Kb6cXj/rd+/zX6A6DEgC62wOA0fM/HEPNjg+++pbkkBKZd+8kGfJ5nU/09QX
	 EWtvDVlHNnUS/TUK7hp2BvQ54aCcfs72ArLxvzcj/T1kKR7Jj1m0CX+Aum9QFMQmJr
	 dV+xs/iazB1Zi8kpMGwP6Z4g+ajoLnccyER/KjejtQHYhT+3qHLUL6RmbX6UE/G+Ev
	 Kx4CPUn5XOvmSHyso2+FwZ9bsukMPSRsd1CEgECrHseZU7oRqPUp2UNIXOiAfc4fdF
	 UtOGA3qPfB9HXYXmp+iKUcB8UuGK1wy4pTK893rtJeUPbkra6a2SmVHJm4/e3pbmI4
	 PG4t5iXZ1TBeQ==
Date: Thu, 10 Apr 2025 18:28:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jacob.e.keller@intel.com, yuyanghuang@google.com, sdf@fomichev.me,
 gnault@redhat.com, nicolas.dichtel@6wind.com, petrm@nvidia.com, "David S.
 Miller" <davem@davemloft.net>
Subject: Re: [PATCH net-next v2 01/13] netlink: specs: rename rtnetlink
 specs in accordance with family name
Message-ID: <20250410182817.7e0b838d@kernel.org>
In-Reply-To: <CAD4GDZw+Enkd2dA8f7pNxMadwURFd_tHv1sUwkXqFqxsOquHQQ@mail.gmail.com>
References: <20250410014658.782120-1-kuba@kernel.org>
	<20250410014658.782120-2-kuba@kernel.org>
	<495e43ef-ae20-4dda-97c0-cb8ebe97394b@redhat.com>
	<CAD4GDZw+Enkd2dA8f7pNxMadwURFd_tHv1sUwkXqFqxsOquHQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Apr 2025 13:39:17 +0100 Donald Hunter wrote:
> Yes, Documentation/Makefile goes the extra mile to only try deleting a
> list of .rst files generated from the list of source .yaml files. It
> would be easier to just delete
> Documentation/networking/netlink_spec/*.rst which would be able to
> clean up old generated files in situations like this.

Hm, that would work. I think it's only the second time we hit this
problem, tho, so I'm just going to apply and clean up manually.
If it happens again I can change the build script..

