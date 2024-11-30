Return-Path: <netdev+bounces-147930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3B59DF31E
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 21:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010BA280E47
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 20:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A647113AD3F;
	Sat, 30 Nov 2024 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtkqhMKp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7692C1AA7BA;
	Sat, 30 Nov 2024 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732999504; cv=none; b=Mah0Pfm1NuhJMeOR39FWQrOCEPYjQOEwzN9E5ILiBxGu7iLNczrZSvqn6kchZgrflpc3qRZ2eobxCLkJvZ0OmgFKdORdmfdhGhvTq5JLDSGRx20PMwfdpHEPMXQ96CIN7v4/NUIVCKmnzy4TaRQ6BLfSHw2eaOBAJ6sudJ09gCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732999504; c=relaxed/simple;
	bh=GG8z///DdezAQyd0jkAuA98/wdVEscORoCXlNR8qgxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tXgak+JZDsLs+JcIBWXxZG+P+C3JbKyWtShH/+gJzFpN6LLmZPEfplgd+BlI2YeC0XjAP31GduC2nI9z2Q5suAx+iAe+3Uiw5sWi72Gb+6lUb+Y3gQIHBXm3CRHPkA1b3CNMnhKhigl+gxIVVLjS2YcmZw/PffTHfN7zTEiZMMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtkqhMKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD9EAC4CECC;
	Sat, 30 Nov 2024 20:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732999503;
	bh=GG8z///DdezAQyd0jkAuA98/wdVEscORoCXlNR8qgxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NtkqhMKpDfG6r8i3nglmXvJS/hHgrWA4Ra8VFqyrY1fmLTKOGPGngVJ5QatBMQYnP
	 B8XIJ+cZ+OUuKE7himppgFPA/cBCuK23QhVAOgl+BB9LxbnVrAWpNK6k6RLHbILzAz
	 TnS8s6C4kErU6disJwgtuDRG3VhDcLE8fmOT8o8TWBLZZREcDxaK4Yj1EJaDGnYOjL
	 LEKGKKOGXK511V8ZxOLV2joMi9SBD2sYA4zuFmZqyFqWGbJN+nzaseTtKxUkVfd13N
	 SFQdNHHgqBmj/tCj8EgROQmi13p0tagfEeDQkRLciz/3I2eOaCuQg7ECqIxLyOV+/N
	 qhyyCtd4EUxBA==
Date: Sat, 30 Nov 2024 12:45:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
 mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
 bjorn@rivosinc.com, amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
 willemdebruijn.kernel@gmail.com, edumazet@google.com, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Jiri Pirko <jiri@resnulli.us>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, Johannes
 Berg <johannes.berg@intel.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 pcnet32@frontier.com
Subject: Re: [net-next v6 5/9] net: napi: Add napi_config
Message-ID: <20241130124501.38b98030@kernel.org>
In-Reply-To: <Z0d6QlrRUig5eD_I@LQ3V64L9R2>
References: <20241011184527.16393-1-jdamato@fastly.com>
	<20241011184527.16393-6-jdamato@fastly.com>
	<85dd4590-ea6b-427d-876a-1d8559c7ad82@roeck-us.net>
	<Z0dqJNnlcIrvLuV6@LQ3V64L9R2>
	<Z0d6QlrRUig5eD_I@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Nov 2024 12:00:02 -0800 Joe Damato wrote:
> CPU 0:
> pcnet32_open
>    lock(lp->lock)
>      napi_enable
>        napi_hash_add <- before this executes, CPU 1 proceeds
>          lock(napi_hash_lock)
> CPU 1:
>   pcnet32_close
>     napi_disable
>       napi_hash_del
>         lock(napi_hash_lock)
>          < INTERRUPT >

How about making napi_hash_lock irq-safe ?
It's a control path lock, it should be fine to disable irqs.

>             pcnet32_interrupt
>               lock(lp->lock)


