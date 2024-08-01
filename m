Return-Path: <netdev+bounces-115139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 931F99454AD
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 00:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C475C1C22CDB
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 22:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5E214C583;
	Thu,  1 Aug 2024 22:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H86qbGEY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20BC14A4DE
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722552729; cv=none; b=DAmgD+qAZx8g3cw3VblFyLLwULHjNB2nomSsUupqwh6+Ue56ZtMLa9guSMwvVvVqM5JXa6DpDVZF1azAtT1wNEy82KIRh5YmfbG6I+zdDIOHq4YmVS9GcyQbzZ8cs5oa6ak+cwMEIRW9FvVIysFL13ttgwA3kcEg9Tg24P5h68A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722552729; c=relaxed/simple;
	bh=iV1sDuDVjgNnv3x9dc2rENRT0wSn4eblpuWQM9pyOx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHX253g3jTbNz2S3FvDOsAkZKMxlvrvjbZPSBgPIH/ilz378RMRow7+E7I40z85bxMNe2xPwJT0uqP2C4ybWrVmwv52dem/iiL6jtSAOzoQeWq0mhUXqWTZ1T7PuGSJlxgef1kU0OLjqMcSjwbCkLurT2MocsJoOwavoS8GH+4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H86qbGEY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B25C32786;
	Thu,  1 Aug 2024 22:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722552728;
	bh=iV1sDuDVjgNnv3x9dc2rENRT0wSn4eblpuWQM9pyOx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H86qbGEYUl3zZ9VzDn/D3nQGH7HQVeyFW2VTsDTZFO0VcJyA9bcGt5PW44vcGxxko
	 kOJ8BwotGYbcCx7h/1M6FV1vYTFTMcO+cKlpZEZ1EmPDlEmgDsQTleyAr0U8LOdPlF
	 5fm2SqHRXASXLvG28IlSUEADLSvjeywFJz0aeQzcIAnefekggYxeFBiuqH0bkkq5q8
	 ugOV7QF9nwtz8b/HszjSiSokJgv9XZqVuCuRWNG0qS1t8A9O2tlm4TQyWLArWVBVl3
	 7iByIJ8XoLSg5jvkU5tXCEvCwyDtz3naT6FDTZ4hgiH/PBjC3u1HVjbVfb7exM61+L
	 HjCoZZb++AQmQ==
Date: Thu, 1 Aug 2024 15:52:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, "David Ahern"
 <dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 0/6] net: nexthop: Increase weight to u16
Message-ID: <20240801155207.1b1c7db9@kernel.org>
In-Reply-To: <cover.1722519021.git.petrm@nvidia.com>
References: <cover.1722519021.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Aug 2024 18:23:56 +0200 Petr Machata wrote:
> Patches #3 to #6 add selftests.

Could you share the iproute2 patches?

