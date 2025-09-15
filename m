Return-Path: <netdev+bounces-223224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A257AB586DB
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 23:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C6D189ECC7
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 21:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7742C026C;
	Mon, 15 Sep 2025 21:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kt8ujA95"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AABF2773C7
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 21:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757972454; cv=none; b=RbbVL4a1/wmpxQRUT7Z+A92Lxu4d4LLkSJ1AkqCW4GYrVvQKfq9HB5Xvm7s1pjt9A7E9OWMakkzEApuN2LE5iFgIIML5ewboGnWLz8UDN1PeEXGqZEFoDhaLT0zf3NT+Yyrvj4QYebHf0ap0vjFuTJHZZ/25hiU1yRo1Axff3Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757972454; c=relaxed/simple;
	bh=xkSgmnStYAOVvKKWZ+gVt7e4kAfeiwStFuYYx4G4DUI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qLgs1Za2b14EwImNfh9FJYuE3XJdO0cc+yWvVoE0mauilSUWp8N5myKu5hlQ/j3mQs44aKcKUfWOIn9p9WyCYb+n18Mdareh6e3kz7GNO2W0pCEelruB7ODI3XESN3YXYUb+Cyyt1l7DcIPK2ILgYmX0lem5VNr0Anp3h9Cwl9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kt8ujA95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 705EAC4CEF1;
	Mon, 15 Sep 2025 21:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757972453;
	bh=xkSgmnStYAOVvKKWZ+gVt7e4kAfeiwStFuYYx4G4DUI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kt8ujA95xQjJv13DuCL7wPGQcasVaolEVwD7HULTAMwMyltKd7Nx7NDDHPscsDHF0
	 h9ZU7RcYcmBS1TefF9OEoWYBLeJh/74SKdv8TYTALlA+/Xdjk4OEbhUwsBJlQhs246
	 r3UhYM28XzCxUykt/R3gJ+w2mXa1zhPqKc8OEw36HvsQAqMZ+PMKFQ7IryW4+9hUgu
	 YbozjdXDk8blKLNkm2aO0/ZUC5jmrgn9XQsX3PPsv0EfSWXmEymFSXImHoiJOrOApt
	 aURXZkH6iX/IzGt/U4CkzUPKVIahk7Pb003wmkdTBKf5F64ygs3kDD2sbh/iplWIar
	 QyWZiaSJx6S7Q==
Date: Mon, 15 Sep 2025 14:40:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net-next] tools: ynl: avoid "use of uninitialized
 variable" false positive in generated code
Message-ID: <20250915144052.6cbbe120@kernel.org>
In-Reply-To: <20250915144414.1185788-1-vladimir.oltean@nxp.com>
References: <20250915144414.1185788-1-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 17:44:14 +0300 Vladimir Oltean wrote:
> It is a pity that we have to do this, but I see no other way than to
> suppress the false positive by appeasing the compiler and initializing
> the "*attr_{aspec.c_name}" variable with a bogus value (NULL). This will
> never be used - at runtime it will always be overwritten when
> "n_{struct[anest].c_name}" is non-zero.

Yeah, I'm hitting this on CentOS, too :(

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

