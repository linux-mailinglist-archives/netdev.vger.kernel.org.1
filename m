Return-Path: <netdev+bounces-249055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCDED13302
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:37:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2ACB3014EB5
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483BD2C08DB;
	Mon, 12 Jan 2026 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDSfCM8d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AF12BE7DB
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768228176; cv=none; b=Ef8N1lFb1UK7zXCId0Hxydr8TOpiyFIWVlrc1Ip6lNH5frobRGT1sdowoEH8ke3QYRs0gkyHKTeFEkjLpUcKhFikSX3UeZU2Xz2yvlLoQRGRjiptLTIHqDC/Zh5AlmP5IIZ8vKF0x+AP3E+z/+OCyqF33wgZLKCPfTHrZryaSxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768228176; c=relaxed/simple;
	bh=q0eCpc7vzq2GKooGVPl0KoT4a1WijhTa4N/80iszJZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LroO6U0vyf6s9AjsyVyHQfhjHCnuIOohzWY4sAEbR9r6ZO/yA26dWLSDEG5hJ7mLtzp1Bqw3ektvnpVjd7qocFx9H/yUfy1NovDvht57uh6lWGcTm0ZHCR3aFTKBExlwgib6YLosZ9326tGslsVL9GRDgYwjXczfrhSnUjKMR30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDSfCM8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5879C16AAE;
	Mon, 12 Jan 2026 14:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768228176;
	bh=q0eCpc7vzq2GKooGVPl0KoT4a1WijhTa4N/80iszJZ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bDSfCM8dgbB4s07U+OpB/0JLXlsA7fFRk+SNcqpAsbmXvCADolVKVjbCvrmdzI8gj
	 dgCXdoeVV333sAnLrzSR/1LRDq2KbMB1uIJCBg+hpWLPXHwfUqHUOYzKVrzPuJ0jAL
	 ZrfwNc4ksZYEP2T9wrkWZ8j3f759ryM4+U0S+WfMS38LXyWZrLmznHN5A4BD/RevCl
	 DUy2htI22D5mTvyIakas+WqxAXD0Z4+tPsS9I+g9wj61lsJbu8cVNDMTh8dhku0wZV
	 eyEoyAwt79NhmTYOPH0s1pifqr0sqlLbjaFvozBvEwmYJ/JAejFZ9ob/a9t5wi10L1
	 DsdkDmdjIU3YA==
Date: Mon, 12 Jan 2026 06:29:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [TEST] txtimestamp.sh pains after netdev foundation migration
Message-ID: <20260112062934.6d1b60c5@kernel.org>
In-Reply-To: <willemdebruijn.kernel.311e0b9ad88f0@gmail.com>
References: <20260107110521.1aab55e9@kernel.org>
	<willemdebruijn.kernel.276cd2b2b0063@gmail.com>
	<20260107192511.23d8e404@kernel.org>
	<20260108080646.14fb7d95@kernel.org>
	<willemdebruijn.kernel.58a32e438c@gmail.com>
	<20260108123845.7868cec4@kernel.org>
	<willemdebruijn.kernel.13946c10e0d90@gmail.com>
	<willemdebruijn.kernel.555dd45f2e96@gmail.com>
	<willemdebruijn.kernel.311e0b9ad88f0@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 11 Jan 2026 22:28:39 -0500 Willem de Bruijn wrote:
> > Can fold in the record_timestamp_usr() change too.
> > 
> > I can send this, your alternative with Suggested-by, or let me know if
> > you prefer to send that.

Looks like we got 30 clean runs since I added the printing change 
to the local NIPA hacks. Let's start with that and see if it's good
enough? As trivial as the change is I have the feeling that is has
to be something trivial for us to fail 30% of the attempts.

Please go ahead and submit with my Suggested-by.

