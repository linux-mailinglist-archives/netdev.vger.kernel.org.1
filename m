Return-Path: <netdev+bounces-220508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67320B46762
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 02:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 316EE1C2600E
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 00:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6FA3FC2;
	Sat,  6 Sep 2025 00:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RaYItX7H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436C6645;
	Sat,  6 Sep 2025 00:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757117247; cv=none; b=ioYtb4mqL7xnU3y19Xeqlxrhg9Vi35PJmW3tRoHClwKB/CGF3nVVJYOF9fQ/nMLTJ4sIDz3wtOpZSiGITt2ffiPvBhN1XcLiPz3a43ZvsBbiMTEb9WhV+dGmT/cTMe5Hb0TfJscDBcUkP0lnQw7h7NZ6ymE0XdpeHLR66szhecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757117247; c=relaxed/simple;
	bh=zYE+E8tCnsrg0b34NooGYBFJYA5zkC/kI80cDxPkmU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+PO/wn/rGdBKp1rcQM4Zi8eqIL0HbMBdQ/M2yofVrglP5eZztVeHRjgkgStHLTZUngtPcIh6wllIFhlOErYpK1m0S+XzKbggvD9Q2ikNQ6lSSmdm9GInOhKMgq/9D2+fTTnM28R87CZ78FjanxGm8AzFkDgpfJIqGpW149KhCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RaYItX7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C12C4CEF1;
	Sat,  6 Sep 2025 00:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757117246;
	bh=zYE+E8tCnsrg0b34NooGYBFJYA5zkC/kI80cDxPkmU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RaYItX7HMlPCJtzaZ6iSHJrQc6glP5zIoPvr54tOfCwePX8/b+FHC33PySiigmcXv
	 b9l6pqkRGgzygknbMRy0J/Emy4Z6hKNxcBm7iIo8bxUS7+ctzOh1uiv+w/l2LipbW2
	 UBtVypzWE8kBGwDkVVsZnCsCvYv85BH8NzwiOMxTM+xk3jJ09dGs/bE7rFCBbYEEXp
	 9iaw0uSVNAJDCDQpf6eMd1XMCQdMbI4XKcmLV0Di6qtrnYFllRaJvI01pJ9qHYKbRN
	 mywsea84URLRiWvaQ5DfE6ByQyD7vaDvzWDYwW+EUjieNgHnPri1DqL9q7pFCGVQB5
	 pMyVO51jH045A==
Date: Fri, 5 Sep 2025 17:07:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Simon Horman
 <horms@kernel.org>, Jacob Keller <jacob.e.keller@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 01/11] tools: ynl-gen: allow overriding
 name-prefix for constants
Message-ID: <20250905170725.20387dc6@kernel.org>
In-Reply-To: <20250904220156.1006541-1-ast@fiberby.net>
References: <20250904-wg-ynl-prep@fiberby.net>
	<20250904220156.1006541-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  4 Sep 2025 22:01:24 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> Allow using custom name-prefix with constants,
> just like it is for enum and flags declarations.
>=20
> This is needed for generating WG_KEY_LEN in
> include/uapi/linux/wireguard.h from a spec.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

