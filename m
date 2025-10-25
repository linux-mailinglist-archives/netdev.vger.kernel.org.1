Return-Path: <netdev+bounces-232750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E119CC088A5
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 04:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB831884C18
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 02:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E87724C66F;
	Sat, 25 Oct 2025 02:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juZ7QNkk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144DD248F59;
	Sat, 25 Oct 2025 02:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761358261; cv=none; b=JYmlbl6dX6HM+u0AL9e6M2e6GCB9xbSzRpfDtsLSzmpoKbGPWUo6Nlkd0cp/z4zcQ2M20L8P1UfVu29ufmQf4YzVsrxpGBVQxdCyQZh2RC5VLtkSBwae/BGMubLUlwW7pWb9M9yzpNEUmxPTJ8hE1WdMOwOZo8JGT9YdQ94xzLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761358261; c=relaxed/simple;
	bh=xnb8J7/V1LN5jAkEi9eJveFA8E6kCbYbJi5PfRNuwXw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hNYFC1SJPYOikaoYI5lPZjdNZx9fAMeLaKhfCjKddwEuU1xmWYeRbqAP9EaPQwSbvfSflzhPY4PgQk4pdZIz/FvYWSs4PHrnXGpoIjm8amsUnF032O2UrFEDZXZ3hEoGcnc/817vhANKwpU2zuX8852ADF/V5wDnPB0eNMoAwEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juZ7QNkk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9415FC4CEF1;
	Sat, 25 Oct 2025 02:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761358260;
	bh=xnb8J7/V1LN5jAkEi9eJveFA8E6kCbYbJi5PfRNuwXw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=juZ7QNkkWjaRYCWcySBjD0LzfdO/k3wNvs9eWXHitGD8wJxKkDl2dQteJWO2QumDY
	 lK0SpUhwg6fujrw7odtW11dig1ojSv0Jt1BIui0y10ODlmmERKtb+153I6bNuFefuy
	 k/2d/uToJmHO7/I0TIUNWyWYnZjjvJjr6j6YqNEHp3AZqHX7GLp3w0cFkrpwmTGd/h
	 3SWMt8bnIhzeME6lQt63hVYtevJnxBp2ZF7EKqwE5DxrEaAh4LCunNdvC9buL79uUV
	 +hXoS1AXrZEF2K1sVC0VmlL7wgPjrz2mha9kctTdZdfV/8+PW/DB1xESmsH8UF5dtk
	 zJws/4foINBEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DCA380AA59;
	Sat, 25 Oct 2025 02:10:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/1] net: usb: usbnet: coding style for functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176135824024.4124588.12685380525387528477.git-patchwork-notify@kernel.org>
Date: Sat, 25 Oct 2025 02:10:40 +0000
References: <20251023100136.909118-1-oneukum@suse.com>
In-Reply-To: <20251023100136.909118-1-oneukum@suse.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Oct 2025 12:00:19 +0200 you wrote:
> Functions are not to have blanks between names
> and parameter lists. Remove them.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/net/usb/usbnet.c | 49 ++++++++++++++++++++--------------------
>  1 file changed, 24 insertions(+), 25 deletions(-)

Here is the summary with links:
  - [net-next,1/1] net: usb: usbnet: coding style for functions
    https://git.kernel.org/netdev/net-next/c/c09b183dc14e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



