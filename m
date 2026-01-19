Return-Path: <netdev+bounces-251260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E92D3B6EF
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 20:12:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86B9030060C8
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3001738F224;
	Mon, 19 Jan 2026 19:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSjMZj/S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D45E33E35B
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849942; cv=none; b=BbinOHwRQLnJbiilT9FTxNHBOZcNRuxQ/7CjVcOxaNLCq2lrOXmYJBG2p0lKqL69wmjtbMx1sgBhgseyWEyZ9bk/JOHOEROSWlAil/aiRpfgNK5yhVVdGqXJWnowwWtkRIQ7BQZtBBdZ9f0deKUEgyRGFGjm93MYXz1mdN+KbQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849942; c=relaxed/simple;
	bh=D+hn1fjq0T00MiWxSUcRJZwg1tPBcmQyhiIKedIeY9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RSVS9qgtEiU5Xaqq5X2/Xx5pBBUT5S58ZNoGpByO299t5ond9qh5h0aObuypOP5IQA9lOszn/kv1PGFBJaPfahYyfm0jLR/ZKysYyThjLTBV5tqg8GkTbJLIy665Vcs6hscNfiKFillXAvRAQSwV/lpMt9LUI56nV9zderI5YA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSjMZj/S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C9C8C2BCAF;
	Mon, 19 Jan 2026 19:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768849941;
	bh=D+hn1fjq0T00MiWxSUcRJZwg1tPBcmQyhiIKedIeY9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jSjMZj/SVleu58Kr1BP9AHcr2Pfv/Rea321IAGbeVXT5NsdQfmODgMPB+9+8E8/Xn
	 VDyWWGKGAfxSQpYJdcrcPZrC72EGi3Amu1taBsj92+aOLCaLdApMHzobR1X5z6/6Tf
	 aGJd1qmWecIRuhlz12iEseCe6s949bN/mq563wYVV/r0v8f0j0MmqMwida0LJybtdP
	 RvInQCsqYvlTl2fMsR1XqxQ8LgkZzcTBYbZiyFG/fTNVSYa93ektrD3wAvsv+VV+1N
	 kVNu4mEPWrwRx/L8xHYvnExoLJLRRWOQpTEjedbFMrBxy4nODhZleMwg/humqDEakQ
	 ZxAnvMNw4/xfA==
Date: Mon, 19 Jan 2026 11:12:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net v1 0/3] act_gate fixes and gate selftest update
Message-ID: <20260119111220.04f7610c@kernel.org>
In-Reply-To: <BYUIZiIrbb9DuEGCzlZalUF5QXjBrQOyJOBOS6fyWQWUJkUN29LhrahP0603mdAW3y5Y7pgSJc0i8Y2O5yJ6ythPAknipI3h4N-aceF6jos=@1g4.org>
References: <20260116112522.159480-1-p@1g4.org>
	<20260119103251.41eb61aa@kernel.org>
	<BYUIZiIrbb9DuEGCzlZalUF5QXjBrQOyJOBOS6fyWQWUJkUN29LhrahP0603mdAW3y5Y7pgSJc0i8Y2O5yJ6ythPAknipI3h4N-aceF6jos=@1g4.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Jan 2026 18:50:08 +0000 Paul Moses wrote:
> The big question currently is what is appropriate for stable. I do
> not believe it's possible to fix this issue without negatively
> impacting the performance of the gate without either using a unlock =E2=
=86=92
> cancel =E2=86=92 relock pattern or conversion to RCU. Neither of which is
> ideal for stable, so more constructive input is needed.

The conversion to RCU looks like a solid choice and I think it's
acceptable for stable.

Let me send you a couple of trivial comments on patch 2, hopefully
once CCed the authors can provide deeper review.

