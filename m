Return-Path: <netdev+bounces-223117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 196ECB57FFA
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 17:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 608B47A4818
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 15:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB70B33EAF6;
	Mon, 15 Sep 2025 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEf97ofT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8194533A00A;
	Mon, 15 Sep 2025 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948890; cv=none; b=tfZnnCVxzrrgHFbHgbZEm6SsNZVOHAc2kA4kfcflVjdKl4f4St6NxRpnejeqL3h0gDWwisuhXe4U/gYdGhXZM93O8UZK+XiPOe4EM8eDNEF6Wtbm06QdSIC5MOG/7lLQK1fD1shgfytgG3NTyLqrZuqPKsF9My/Vs1efkzmE6vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948890; c=relaxed/simple;
	bh=9O1z56vqtNhkEAwEZtm8PUBGm1bOeajXjsDFzJG0/FU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XpvAsNbk0YoId+vXLKesE49juEINC5C6awh4oifhbPFIcNYiISZnHlDOdINAkvWXay48RZ8J9sZAViF3LhdYAYjq96lNJf+shnURjW4NyWmjGF5EffXpoiwjmbwm2OhUHFjqmHQiy2DYSNHyOt73+DWQujWOdO1a5HliRk4ECLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEf97ofT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EC2C4CEF1;
	Mon, 15 Sep 2025 15:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757948890;
	bh=9O1z56vqtNhkEAwEZtm8PUBGm1bOeajXjsDFzJG0/FU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TEf97ofTGi6vLmzHoMeh4MdZj46F9xE0ZUXiXh7+EOsRH0EuhrrCLgJXzf8pV6kek
	 Kiex34sgMRDGMxwUocRWjtjEoVHRVxLKEikyx457Y62wmgIurTDM5wUmkzPTRk4lM1
	 uXoIqkregnlUWb8fwA0w9UjiVHIAf7FJTBPOrj+SfB3EvJAvtsFUwI0MMRMwiMwPjl
	 npLXeniBnSXXnc3cBPR5Qohj59yyUT9rVk0hi/3aO7JaztsV5ZL/He5ueOONwP48Tv
	 3ZCjA+Vmx8Gh7nwUl01pUX/jzFx3i7KkbW57F+5E7QUwFzI3ghL8Kemeg24MaD9fmw
	 Zszf/PAKQkBEg==
Date: Mon, 15 Sep 2025 08:08:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Prathosh
 Satish <Prathosh.Satish@microchip.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michal Schmidt <mschmidt@redhat.com>, Petr
 Oros <poros@redhat.com>
Subject: Re: [PATCH net-next v6 3/5] dpll: zl3073x: Add firmware loading
 functionality
Message-ID: <20250915080808.7a4f3444@kernel.org>
In-Reply-To: <4bd1847b-00b6-42a6-8391-aba08aeb3721@redhat.com>
References: <20250909091532.11790-1-ivecera@redhat.com>
	<20250909091532.11790-4-ivecera@redhat.com>
	<20250914144549.2c8d7453@kernel.org>
	<4bd1847b-00b6-42a6-8391-aba08aeb3721@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Sep 2025 10:18:03 +0200 Ivan Vecera wrote:
> > Still worried about pos not being bounds checked.
> > Admin can crash the kernel with invalid FW file.
> > 
> > 	if (pos > *psize)
> > 		/* error */  
> 
> This cannot happen...

My bad, I didn't realize %n is magic!

