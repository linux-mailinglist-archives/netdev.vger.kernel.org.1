Return-Path: <netdev+bounces-77205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 430CC8709D5
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 19:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A08A1B2A216
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 18:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA747992E;
	Mon,  4 Mar 2024 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYa92XIB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A84579927;
	Mon,  4 Mar 2024 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709577419; cv=none; b=YbEJ/ozCYaXK4ni28oUwJYxb6cpJUh4ZSlmt3FpzhSkJnFwmaV7OFJ7FoBqj0i7C/UnMzuVv2nG8/7TqbAQzlTF5y3buXnyQpGTIKiV8VbrT/oT/HyCANEhKP0NXYnVNwpIzYCq+Qqe2LkBmkTuJyWpF3ryQ9o29AC1yItQ1zGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709577419; c=relaxed/simple;
	bh=y9H65uUnrsqANVDiN2gYs39+AfbnxLFMPz9KXjKOtno=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGl32YloEEFBPTfPZ0w5EpUF86cF3lS68D2s6djii17Tgz4cj6dq6uHb8KjJWTPhC4sAUlGZbaqLJbFb3NEqCCyhQWIZbuU61LjvirMw8R5mhW1CjYkCps8OppmSpKXJYrP+XyYwCrpsv0qccJDM6py2aABaD6xCzvLY6eYrcTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYa92XIB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89199C433F1;
	Mon,  4 Mar 2024 18:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709577418;
	bh=y9H65uUnrsqANVDiN2gYs39+AfbnxLFMPz9KXjKOtno=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=uYa92XIBlLNcQvTdf7bT/17O9NOJLFkC6FGdTUF5V+ObcwWa4qgRZ5EIJQRtosIw+
	 9nbV6BI4Axzfk8oZERbxkVBeGF2TBXbGV4D7tH0BWnA5RfZMQjXHYftr1jl2Jq72xb
	 107jzxnJrLwsoSYmt6caRzS00AU//tfgEkqllPgW2sfQc+eXKjSASATKZs7AbAQNTg
	 +qp5T+k2Rezsr8kFPS/40MAsTAMlQ1xumhAIVoxcQZyUoL0k0N7OSS/Oe1g7KgaeeI
	 yuZ4YIQ/uyaBSs2jQQYoo2NjxSVgoly0+Ne6p82QXR0uR4Ua82OMGfV+8n52VnuSGn
	 hEPU5nZVqRC6A==
Date: Mon, 4 Mar 2024 10:36:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Mar 5th
Message-ID: <20240304103657.354800b0@kernel.org>
In-Reply-To: <20240304103538.0e986ecd@kernel.org>
References: <20240304103538.0e986ecd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 4 Mar 2024 10:35:38 -0800 Jakub Kicinski wrote:
> Hi,
>=20
> The bi-weekly netdev call at https://bbb.lwn.net/b/jak-wkr-seg-hjn
> is scheduled tomorrow at 8:30 am (PT) / 5:30 pm (~EU).
>=20
> No topics so far, please reach out if you have something to discuss,
> otherwise we'll cancel.
>=20
> The reviewer of the week is.. Meta!

Sorry, ignore that, ENOCOFFEE.
The next call is scheduled for the 12th of March, not tomorrow =F0=9F=A4=A6=
=EF=B8=8F

