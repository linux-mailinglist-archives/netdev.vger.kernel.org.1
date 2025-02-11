Return-Path: <netdev+bounces-165310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC19A318A4
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 23:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2921688F6
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 22:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1AD268FC2;
	Tue, 11 Feb 2025 22:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUjY/g/+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4E5267B05
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 22:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739313155; cv=none; b=KK+vCXnphM5zrqwx0vwy133MmloHUu5S20XTLSX9ZdEYjofxU5ve9U2Ow0rzBrpAO7LldK1CaU5f12Ha9wnAjxpYG9Es8hjee6NSVhdEnM3U0FNvnpqKInospxdyQs/R6esGeJVNRogjnt31U1yn4wYa5XbFfJbIE1LuVAJCqMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739313155; c=relaxed/simple;
	bh=2YMIRQWOPusEe7Utj8SbuKPTU0p8xB8RRbgq3tYtpz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZeoOkbEHOjrgifuPHJgyZ2N4s0IrXMIyOB8uoltk1BUgLlrWBU2UBuQ4kcVD9FX4TAUIb9NOsC9JU/9c39OZkiY6/wfsB8sZvAp2HUo+Q/92YhysiMH/ElmGdwhs+VizXrtNhN0F0zxogSycn7S+RloZaX5Fb4gS8REPmoBDhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUjY/g/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03ACC4CEE2;
	Tue, 11 Feb 2025 22:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739313155;
	bh=2YMIRQWOPusEe7Utj8SbuKPTU0p8xB8RRbgq3tYtpz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bUjY/g/+1Hc6nWd5alMJvD1ohv8EyNqeFKadzZBctvPd7Bg68spuDjOP1U0CG1bU3
	 S9cJeJ249UBfVcMfLNckSiWacjI3Mubf19Jxn+Y6ttshU8Ndy493AEVRFH6WTW7vq2
	 pm+lLTCVr+kgL88NXZKdbVAsKdQ+IrtlPJF3LW8biDNtxFOLXryx+Q3dIi5gpfIAwd
	 aN/Ulw0JznSYCEbfFrJrWIjlfj/SYT5dySzh/DLHG3LKtIMWAODsbnrKuO1376gO4e
	 OdUnnXYuuiFLeA89TdPI8+LCgNlXpz1pQniOw0ooTKQoQlXOYB8EYpeQeGupfcQyE2
	 51VclmQVtEnlw==
Date: Tue, 11 Feb 2025 14:32:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: davem@davemloft.net, alexanderduyck@fb.com, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org
Subject: Re: [PATCH net-next 5/5] eth: fbnic: re-sort the objects in the
 Makefile
Message-ID: <20250211143234.1733c071@kernel.org>
In-Reply-To: <Z6uq_f7knvHIhFT_@LQ3V64L9R2>
References: <20250211181356.580800-1-kuba@kernel.org>
	<20250211181356.580800-6-kuba@kernel.org>
	<Z6uq_f7knvHIhFT_@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Feb 2025 11:54:37 -0800 Joe Damato wrote:
> Incredibly minor nit, do you want to remove the trailing '\' after
> fbnic_txrx.o which is the new last line to keep the format
> consistent with how it was previously?

The point of having the comment is that the last real line can have the
trailing \ and therefore will not need to be modified when an object is
added after it :)

Thanks for the reviews!

