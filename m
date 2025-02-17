Return-Path: <netdev+bounces-167120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21878A38FAF
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 00:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 044B73A62F3
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 23:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2911AC882;
	Mon, 17 Feb 2025 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="er0ZcjQb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3B315666D;
	Mon, 17 Feb 2025 23:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739835431; cv=none; b=i6sI9mE9H4ZZu/Gy/TtMcitNTojHuMAevzNGbdx5QD2TwXHO7Qaliu7/uevwtU/LOO4zPWxUDWiu1wsMSAabDgRNlxBV6cU1JXfRgWBqd3SFq9Lh6epJyIH6x93qzufSgTtjH7vxLIL6SJVr65uEZ/qSkQNddQTyuQKcI8ZMRlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739835431; c=relaxed/simple;
	bh=lYbE0SAfYIia+ES5GmheRgynkRFOmIJkICc8YdbeYRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egk1zQQyvQ4Pk+61Sk/dqcEcTWgAlkxIB7ewooo+pFFAskVH61tXJFuOMB154yhyzfQZX7YM1KJmQSyjgASQP4JWifsdJ5R+P90bhGhOjXe8vRFOO5BnpNf2ejpemwbIttMkswcmWQWY3da76PyIzRpTvvFPxcnB4BFp5AQiUcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=er0ZcjQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7823C4CED1;
	Mon, 17 Feb 2025 23:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739835430;
	bh=lYbE0SAfYIia+ES5GmheRgynkRFOmIJkICc8YdbeYRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=er0ZcjQbSaxvBEiRqXzMiWOBKwtedYkfxwI3roN2O29jl5BOIz3cNgcM02lkE6lbK
	 HYBA4IEHONbxm2/0OekqR7qhtG4/WWjdl8QsUPgWnNNtanB14yVo6g0Ms+24uMz886
	 4e0SEv5Aj33CRwYn+gMlXs1qoqDCFqVti9O8AHYWmraf5Z3bMGU9s077fYP/7ejxD/
	 kj0iYEzpEciSGg6556xS2ixaQiNJLt4Zsan3Zm6AYJTFsVxdlQSEyvA0PrvwgaYE54
	 Yzh7P2B4dkQf3gorsvdPqanWEym++4DzYgiTuh3xXi4LDxQG1b4WUxEtqc63zw1FtP
	 qeqIFIJ3AEE/g==
Date: Mon, 17 Feb 2025 15:37:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Suchit K <suchitkarunakaran@gmail.com>, netdev@vger.kernel.org,
 horms@kernel.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] selftests: net: Fix minor typos in MPTCP and
 psock_tpacket tests
Message-ID: <20250217153708.65269745@kernel.org>
In-Reply-To: <0c5f1dcf-1bd4-4ddd-b6c0-e3ee2b3671ea@kernel.org>
References: <CAO9wTFgN=hVJN8jUrFif0SO5hAvayrKweLDQSsmJWrE55wnTwQ@mail.gmail.com>
	<0c5f1dcf-1bd4-4ddd-b6c0-e3ee2b3671ea@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Feb 2025 11:08:36 +0100 Matthieu Baerts wrote:
> On 16/02/2025 13:25, Suchit K wrote:
> > Fixes minor spelling errors:
> > - `simult_flows.sh`: "al testcases" =E2=86=92 "all testcases"
> > - `psock_tpacket.c`: "accross" =E2=86=92 "across" =20
>=20
> The modifications in MPTCP (and psock_tpacket) look good to me:
>=20
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Thanks! This patch is corrupted:

Applying: selftests: net: Fix minor typos in MPTCP and psock_tpacket tests
error: git diff header lacks filename information when removing 1 leading p=
athname component (line 7)
Patch failed at 0001 selftests: net: Fix minor typos in MPTCP and psock_tpa=
cket tests
hint: Use 'git am --show-current-patch=3Ddiff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort=
".
hint: Disable this message with "git config set advice.mergeConflict false"
Waiting for rebase to finish Mon Feb 17 03:34:36 PM PST 2025^C

So repost will be needed (unless Matt wants to take it into his tree
manually).

> This patch can be applied directly in the netdev tree, but I'm not sure
> the Netdev maintainers will accept that kind of small clean-up patch
> alone, see:
>=20
>  https://docs.kernel.org/process/maintainer-netdev.html#clean-up-patches

FWIW spelling problems are explicitly called out as okay there.
--=20
pw-bot: cr

