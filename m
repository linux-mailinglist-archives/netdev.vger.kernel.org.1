Return-Path: <netdev+bounces-239775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E955C6C546
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EC174E142C
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098022472AE;
	Wed, 19 Nov 2025 02:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBppDWsP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D976F2E40E
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 02:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763517936; cv=none; b=X+FowOzTC7ctoJkyxkW4y+zHVq2LgbDY7TGGXWWAciivGyHMovxGoInBEYynVMAMB96+6YmT8kv0dvcxJBcRqJPyx0C7IqoVnlO0siXJ68oWjR1arnORp0rsvWrpLCfu/2UVBeND9ipnLZlvEscCXRNUyV3LPNZw/cU2/XoAIeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763517936; c=relaxed/simple;
	bh=fgFlOY+nHmZTu7GS7/pQvOeT/W22CuWqurtMfbJcKkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSYPanxp7KZ0W7fkWjZ/vSmpYzv8EY//sX73bkF58p3PoiMmaEK3uySzFKUZl7jr8MlUE7k50fbxgGblkX2iZTCFIktU0aqkbxakR6XKn2QCAaA3bOZLtstu5GWrSTzs5HEt5h8nk9P7a9xTu2g6oVVpYbrAc7KuU/gU3oxtx40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBppDWsP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7908C2BCB6;
	Wed, 19 Nov 2025 02:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763517936;
	bh=fgFlOY+nHmZTu7GS7/pQvOeT/W22CuWqurtMfbJcKkA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WBppDWsPATnuYWi9+EhNqrxpvmOnykq6qvpkGR2UpJKh3EgzwvZaC5BbQNZq3w3Wl
	 XaJkYKMuMXew/nyQoFsNmJjaplbJzUNIRQKw+YhyPp9/U2stC6GMKr1DZDpbF7l3nw
	 ZM4mDVcc8yBJNDO3v6LglOaymf04lzw06GE2xceqqrNO2+t1MS3nd9S4/Jc7ryXMfI
	 g4aCYrsAwp9cgqrNtluaJFBjDbAdW1WOBXYXVmlWOjzBorlgSkh89hTnGoYpADdMOi
	 gChSXbkZJ/ZaBUVDgr6yd5yfxGmqdQUIqRvig5FI1AgBM5poCFS/Ia2D65H3Cnd49S
	 W8ecpGSL7EbXA==
Date: Tue, 18 Nov 2025 18:05:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?UmVuw6k=?= Rebe <rene@exactco.de>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH V2] net: 3com/3c515 fix build error
Message-ID: <20251118180533.4aae2524@kernel.org>
In-Reply-To: <20251118.121556.485782007294139002.rene@exactco.de>
References: <20251118.121556.485782007294139002.rene@exactco.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Nov 2025 12:15:56 +0100 (CET) Ren=C3=A9 Rebe wrote:
> 3c515 stopped building for me some time ago, fix:
>=20
> drivers/net/ethernet/3com/3c515.o: error: objtool: cleanup_module(): Magi=
c init_module() function name is deprecated, use module_init(fn) instead
> make[6]: *** [scripts/Makefile.build:203: drivers/net/ethernet/3com/3c515=
.o] Error 255

Looks like this has already been fixed by 1471a274b76d1469a

