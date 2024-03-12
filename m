Return-Path: <netdev+bounces-79521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4126B879B51
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 19:26:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1D51F21EAC
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 18:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1CF139574;
	Tue, 12 Mar 2024 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="gBui7r/c"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3377F7CF
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 18:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710267965; cv=none; b=ONUQ8Sw2Bg+LgaHR4xebvtH32YcOqOyA0aS+7CU4ie0t+WS7aRV2hFmQKHly7SaoPOmYUsvfvuiOr8sCWLj4i6O3rTdM+WSRAQGe8jYzMQac2+HDxlny04riM/o6tg2xL0Tbn717eka7EOLIpewcolUQFBwSbHpNG6cVKgAiHec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710267965; c=relaxed/simple;
	bh=cbzqhL7QNLlRwxrZl1a9IcLDeHzJoeGLmf497tQgvPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AnU9kWORyKnE9s+swHs2uSMUEGlE/EyDtqqW3bsbXm2ww0uvhQIoMjqPJWqitrwijmj0Zaid9PsycZL2DAbmF/X67UiXna9fSm/w2/kQHmbihqLT+JgXxYu2CF+a+7aben5rqsTD98XwQGJ8lfGgYOpCiTAD7CDzvnuf9T+Ve6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=gBui7r/c; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1710267954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DEL4cjEyuWba9hd0VuaR1DyNAtm+hNflQGQLLZ9qcC0=;
	b=gBui7r/ctXj3eu4a/QMGKWEfJHu6zzn2OMqHmMlXf91K0tteGcwhTd0QlEdgYVmjLYZUZd
	924r2x9JX0Pg9cMbrxWgDuUUs/plVf8KM4UR7BrJxfRzEVDr9jnavhpt97v9uEFnqCbpem
	hzbbNyj5ND9/O4OxMCo6eLcOUOlV11Y=
From: Sven Eckelmann <sven@narfation.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Simon Wunderlich <sw@simonwunderlich.de>,
 Jakub Kicinski <kuba@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org,
 netdev@vger.kernel.org, Dmitry Antipov <dmantipov@yandex.ru>
Subject:
 Re: [PATCH] batman-adv: prefer kfree_rcu() over call_rcu() with free-only
 callbacks
Date: Tue, 12 Mar 2024 19:25:51 +0100
Message-ID: <3554205.iIbC2pHGDl@ripper>
In-Reply-To: <20240312181628.2013091-1-dmantipov@yandex.ru>
References: <20240312181628.2013091-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9250623.CDJkKcVGEf";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart9250623.CDJkKcVGEf
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Dmitry Antipov <dmantipov@yandex.ru>
Date: Tue, 12 Mar 2024 19:25:51 +0100
Message-ID: <3554205.iIbC2pHGDl@ripper>
In-Reply-To: <20240312181628.2013091-1-dmantipov@yandex.ru>
References: <20240312181628.2013091-1-dmantipov@yandex.ru>
MIME-Version: 1.0

On Tuesday, 12 March 2024 19:16:28 CET Dmitry Antipov wrote:
> Drop 'batadv_tt_local_entry_free_rcu()', 'batadv_tt_global_entry_free_rcu()'
> and 'batadv_tt_orig_list_entry_free_rcu()' in favor of 'kfree_rcu()' in
> 'batadv_tt_local_entry_release()', 'batadv_tt_global_entry_release()' and
> 'batadv_tt_orig_list_entry_release()', respectively.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

Ah, SLOB is gone and now this is possible.

Acked-by: Sven Eckelmann <sven@narfation.org>

Thanks,
	Sven
--nextPart9250623.CDJkKcVGEf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF10rh2Elc9zjMuACXYcKB8Eme0YFAmXwni8ACgkQXYcKB8Em
e0ayBw/+PY9ZT4UuSHO7g9WrUayT80ugNYy7kfyMMw4Ft730jLh5bGq3ckVrR2Vb
/qaKgKMO/1//pYbxs9f73Ql3UQErr8kL0EZnkAXoCWGmmByPrx8TFltJGYdqwJcC
gz9Fb8soul84hxe92+EErr66a7AExZgV4/Z12ift+bwflUNXGxPiBdwwZv8RmgkM
NnWrmxNnnYsfpMNGtSbDFQGO8Ubv1/Q2Vq9bbbSAC1FqGcsFLrsfL0pgmscLClSC
A5CvYgkT3ZGGKsiZKSPTEmb8Nsy+0GCbhLTp93mb9CHaIZcl/ydFp01K8vXGYMz5
nv0mYABhnV0Bi9erXyHQTcHFrNCIxW0bq4HY163YmN42e8PDXLXa/H7QmWYmKDOQ
TM85Fxk6idvWqejBELm6ZwuV8I9bH71lXfgK5dOzURS9/y2DTCIzzbYr/n9RuuRU
2tZYsg95SPtvLxnC4Ctf6MMfI13M3v3DhMeO4sBhm8j9Ui+vTt98ubz6kRWxxImd
Ea+8IGmWtwBYVKR5xrrQxyzNVG2hRKZ/amE1OytmfuKqJBDTv0jXjchjK+z8ldLP
edvy+8GtvXO1/um2W4V5Opqe5CJ8tXRsje8bszErWu2AABqgS4Tb9On7atfBFdqa
NRfMvFc080ep2NYg4Yeyg6FwJ4ymUWUvFZkCxhdhv9au3mniJmM=
=dCS4
-----END PGP SIGNATURE-----

--nextPart9250623.CDJkKcVGEf--




