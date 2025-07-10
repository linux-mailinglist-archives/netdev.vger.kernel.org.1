Return-Path: <netdev+bounces-205875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F948B009D7
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 19:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EDEE188AA0F
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7612877EE;
	Thu, 10 Jul 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUu4gP71"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F2627F198
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 17:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752168193; cv=none; b=kKWJKqslDYtJUoPqttv9114FablNJm4AWx62e3yya8eL1fdz0NhiGdqG6zTDFe1/8nXh2+fhJ1QoUeyNAMAK26QboglFlfqU3qm0Pd3X9uMAS9ysuug0HbvV/Q6cN7Pk5FEP66dQumJDYa8qGGkiyoFVkNxc76fMHj3/iXtGaPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752168193; c=relaxed/simple;
	bh=B2TK+ftpnBWjLCVkZPBh/iwQ3C/9VlwJZpHkSpyYowU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjSPW6qZvEYLVytR8lnXelHbZe4bvrrLggPwGX+X/LIgULpOA7rFR1VQ+/wPqJh5Bu6v8DBIK/xYjxMOzpWAmri6rBSBM5b7WhLbXSWcjBcaBfqqWLuIf2S2QjyNRdKL0+eBS29RfaiM0o436kAkk310fOOMlwkT2ucO6StuGFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUu4gP71; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4403DC4CEE3;
	Thu, 10 Jul 2025 17:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752168193;
	bh=B2TK+ftpnBWjLCVkZPBh/iwQ3C/9VlwJZpHkSpyYowU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qUu4gP71HIsjhfyxIJDTBzB746HzRa2grE0D8rfrFjko1kJy8s/4rO9/N8WmfstkS
	 cKordWFp5u9pbxvHdsr1J9fekLX9yvn8OcSvYv8KRozr1bmdEypgiZprcw75iyySsu
	 gpsj9cvNAvIt+fk5aBN1eR1j1WUJr0iYd46wwqlZP0E4NYs1mwaK9QbGk+xDD2NYhW
	 ufiKeBxlLBhiNXgAU7zDxWx2Lbiffqchbd56s4eds1Q5t6sEohdyG4tKrnNFfhMIbT
	 A+6VVZJZTtZHgaiKq3wqofMgh8p6uC7oEc7JcXItEjMHjbPtrrVJAbXomswSPpKKQ2
	 Px7Fn9M0EA0/A==
Date: Thu, 10 Jul 2025 10:23:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Subject: Re: [TEST] net/udpgro.sh is flaky on debug
Message-ID: <20250710102312.5c33971b@kernel.org>
In-Reply-To: <0455186e-290f-41b5-b2b3-78d5bfa2b74b@redhat.com>
References: <20250710070907.33d11177@kernel.org>
	<0455186e-290f-41b5-b2b3-78d5bfa2b74b@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Jul 2025 16:20:28 +0200 Paolo Abeni wrote:
> Something alike the following. I can send a formal patch, and we can let
> it stage in PW for a bit to observe if it actually helps.

Added to the local hacks, should start showing up from
net-next-2025-07-10--18-00 onward. Thanks!

