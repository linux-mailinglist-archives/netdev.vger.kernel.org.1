Return-Path: <netdev+bounces-173816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFB5A5BD9D
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 11:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FF4B17647F
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 10:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC952356AA;
	Tue, 11 Mar 2025 10:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTIHO+ic"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5CC235377;
	Tue, 11 Mar 2025 10:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741688374; cv=none; b=JYNHs6QLxRGeqnYOOz4snGa0DI6jvyJcIt/WSM/86Ue01ugZuYXnKQ0VxM/Ty7t1Ry2s8IBR6AprBQDqXizEfbBZmu1Qo9NwGtckX02fzyhYXdKUBulOLLvPyDQmxCdYmyn+Xz3jGzbveAUtfIZqIUCGyYXIOBEcT0YPmgs7mig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741688374; c=relaxed/simple;
	bh=+xPZ7oJ1rK0sJIEnJAfAEcYAAynz/asIz+7ZTOxdeOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+l4k9tz+0xp3zVP8L6BZWxoyq49p1bneCkCzqb8poFvVbhFZuGQ72aGCJP8YPcFLn6g3jQ6D8eI0EGo3jLevkMHqhr68tle6/DvrruZQw48bcA6daX800vfFVZvr9n07u33PULrI+iRxP47p2prM8SKMr3RUYTcM7+kpf9CP3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTIHO+ic; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053EFC4CEEB;
	Tue, 11 Mar 2025 10:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741688373;
	bh=+xPZ7oJ1rK0sJIEnJAfAEcYAAynz/asIz+7ZTOxdeOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cTIHO+icwb75SEpVaz+5aU9okABktvtSt1vV/wVPmnE7l2V5h2nY0+hvCyNOiruf9
	 bPVcOGFG+PSk3yoVEmWcMEmCIS2+0kqhWkCBNAML4kvm3tvSITW1zgL+vKCGNk3SP0
	 Pgk/IuWZ8hGqb367a300CDsAYi6xX4Q5TXbGjyoOm37ss8HKYJCBpolRS/2EqjuIau
	 PORjW1Asx2UdgCpKxT16avleH//trR79dmzcQ9Em6shK9Wis1b739Mx6DgfF7FA4yA
	 SMfPZurowDB8MMJLcMDDXjQKw4g860Goa/aulabYA7/Vd/4ltjuCS/8bFlhLuaKTQp
	 nO0cM0O0AdQHA==
Date: Tue, 11 Mar 2025 11:19:27 +0100
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] wireguard: noise: Add __nonstring annotations for
 unterminated strings
Message-ID: <20250311111927.06120773@kernel.org>
In-Reply-To: <20250310222249.work.154-kees@kernel.org>
References: <20250310222249.work.154-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 15:22:50 -0700 Kees Cook wrote:
> When a character array without a terminating NUL character has a static
> initializer, GCC 15's -Wunterminated-string-initialization will only
> warn if the array lacks the "nonstring" attribute[1]. Mark the arrays
> with __nonstring to and correctly identify the char array as "not a C
> string" and thereby eliminate the warning.

Hi! Would marking all of u8 as non-string not be an option? How many 
of such warnings do we have in the tree? Feel free to point me to a
previous conversation.

