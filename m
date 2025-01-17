Return-Path: <netdev+bounces-159460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C03A158EA
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13CB3A1767
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 21:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FAD6149C55;
	Fri, 17 Jan 2025 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhlQR1g5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2607E1A83F1;
	Fri, 17 Jan 2025 21:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737148633; cv=none; b=DiJ1lOj6UJByy+6UFB0UKpm/mWFtm84Ob5HuJYT/RAHvXg6PF1q7wEn5LJ9W+cL0zSGAawU9kwFzlPkpNZBliWU7LrsCMZeAtbRt4o0Kt9IdFA+5Zlfyy6OXDRDpj/xoo1Ol6HvGuXdFAEM2P+RBIoWYLTOYpFsM5I5euxt7WCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737148633; c=relaxed/simple;
	bh=jqUxzDsh4oIjs8UiUgCohjXIwK0VU1y3e7GK6AqP+Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hurgILHnuTwncJLIDaXRDKKB8Nuvw80UTeQp836JweC0UrkD/TmW7YOVV8oxgeqlLuS95v8iwLw5xYU2tShVeKxZcIKca9Lr8qEODapaMA++mgRXMMbLuyIlWTIRFUhyt74seqCyJ7KTTaGwOm47Lw+oZmUUYF4obOrZBzeHHOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhlQR1g5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE23C4CEDD;
	Fri, 17 Jan 2025 21:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737148632;
	bh=jqUxzDsh4oIjs8UiUgCohjXIwK0VU1y3e7GK6AqP+Mo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EhlQR1g5U1silNCe0o8dVYdpNr2fT7v2yJmtL/XNsg1HwcSoLVIWHDSuOAOFrLVkZ
	 EEgZORolzfbct0Ni2hx7k+RoxeEYWpGegLVnN475NFVfYRhRzNNdWPlV0UQvVA8uKE
	 dwBmAZGOVYx2JMj41JpSJ5w8WHhWyWtSxxY/DwezP5fOSPVyeFJJ9Au8xmUIPEvpc3
	 2PgNdMeRE8uVq7bkjmWe5FLa4ks/8FsnWybpBR0PmVVW+3tdx4nB4tUBAM+w5SuZV5
	 NhL0c2fK+jenwViZ0JU9pam5UVMDBeQ4MvWLmPB018/dCRAaT0VFzhzLQujTERlI08
	 HwPtJMGwPjsFA==
Date: Fri, 17 Jan 2025 13:17:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: David Miller <davem@davemloft.net>, "linux-bluetooth@vger.kernel.org"
 <linux-bluetooth@vger.kernel.org>, "open list:NETWORKING [GENERAL]"
 <netdev@vger.kernel.org>
Subject: Re: pull request: bluetooth-next 2025-01-15
Message-ID: <20250117131711.2b687441@kernel.org>
In-Reply-To: <CABBYNZJ_LfmEzZaZjxwY7uG8Bx1=+-QE5B07emtz5sios9XZ0A@mail.gmail.com>
References: <20250115210606.3582241-1-luiz.dentz@gmail.com>
	<CABBYNZJ_LfmEzZaZjxwY7uG8Bx1=+-QE5B07emtz5sios9XZ0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 11:17:36 -0500 Luiz Augusto von Dentz wrote:
> Looks like Ive only send this to linux-bluetooth by mistake:

Could you do a fresh repost? patchwork will not gobble it up from 
a quoted email :(

