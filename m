Return-Path: <netdev+bounces-223226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C4EB586F2
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 23:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60DFA4C2D1D
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 21:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE5A29BD9A;
	Mon, 15 Sep 2025 21:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4/xr1bx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB9D246BA9;
	Mon, 15 Sep 2025 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757973128; cv=none; b=QPu1I7pybGktae6gHteu2PUyYXp27CgCZUX5SmKQ7rUQwYycPw0pTZxw1EY7cDvMiA+L8dIcMShQtpMwn0nxhGVrjfHZ3b8xRZkUSMm39QnfHMSB/zuHDXBxc/8jCjGHse4TNXhZU7jFnqBHthhyfwLNadZ2hA05WaG6USlBVqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757973128; c=relaxed/simple;
	bh=HJAvMCQ9YzgB0TDixp0g9RFaMEwF2w6O5TFHhHuAYME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=co4NzwnkfjbE1ffQeWs2sydo7K5C5j4qIUvrRefqWV9GqHhK7UCnko7n83v0SiSdhmBp/2wacp9XTqpv1PUAZNj+5vuETKFQROGMhG4F5Y86xmzsQtgbmMZKy2Ja8MQgk4/56iirRHAukO4SQcOy7BZDVq01tJNMBbJUneSpWBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4/xr1bx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BA2C4CEF1;
	Mon, 15 Sep 2025 21:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757973127;
	bh=HJAvMCQ9YzgB0TDixp0g9RFaMEwF2w6O5TFHhHuAYME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i4/xr1bxQKkyLeLUG+5FXmU5/aSDj/rZYdWcKQ2JwWeIKZqru5AKLiiti+LGVMNhx
	 rJSpBfdqnAt/4R5N4HIzFkVWa81UpVLP7dTub25Cp5lXf+uPLVgEhX18291bDPyGBw
	 jF6BWsUZQOO/mw8t5xCvVeH8er5MK2svziUAt3V9JVZySDeQqwHKmzD/jTYCFUQAmP
	 1WvHM1y1xE3PzFe7npjOwNIxKPBRwArHWFKDxdnuvQEIDFqgv6ux/TM+jLbt4uos3u
	 THzKHj53qTxA+d5DiTfsHFtuoaBce+Fhc14iv8yZKIZsVkF+woLYd3Ow0ql/7GoQwP
	 RyAFx+Yu0AfSQ==
Date: Mon, 15 Sep 2025 14:52:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, vsrama-krishna.nemani@broadcom.com,
 vikas.gupta@broadcom.com, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>
Subject: Re: [v7, net-next 06/10] bng_en: Allocate packet buffers
Message-ID: <20250915145206.74a59699@kernel.org>
In-Reply-To: <CANXQDtaB7HcSujG1R9i90YUB6PdOin4=CsKzGvNX6tGMw8n+mw@mail.gmail.com>
References: <20250911193505.24068-1-bhargava.marreddy@broadcom.com>
	<20250911193505.24068-7-bhargava.marreddy@broadcom.com>
	<20250914133150.429b5f70@kernel.org>
	<CANXQDtaB7HcSujG1R9i90YUB6PdOin4=CsKzGvNX6tGMw8n+mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Sep 2025 23:26:07 +0530 Bhargava Chenna Marreddy wrote:
> > You should have some sort of minimal fill level of the Rx rings.
> > Right now ndo_open will succeed even when Rx rings are completely empty.
> > Looks like you made even more functions void since v6, this is going in=
 =20
> I changed those functions to void only because in this patchset they can=
=E2=80=99t fail.
> > the wrong direction. Most drivers actually expect the entire ring to be
> > filled. You can have a partial fill, but knowing bnxt I'm worried the
> > driver will actually never try to fill the rings back up. =20
> I believe the driver should return an error if any buffer allocation
> fails and handle the unwinding accordingly.

Yes, that's also my preference. I think allowing Rx buffer lists to not
be completely filled is okay if the driver author prefers that, but in
that case there needs to be some minimal "fill level" which makes the
device operational.

Speaking of Rx fill -- bnxt drops packets when it can't allocate a
replacement buffer. This used to be the recommended way of handling
allocation failures years ago. In modern drivers I believe it's better
to let the queue run dry and have a watchdog / service tasks which
periodically checks for complete depletion and kicks NAPI in.

Getting constantly interrupted with new packets when machine is trying
to recover from a hard OOM is not very helpful.

That's just a future note, I don't think this series itself contains
much of Rx.

