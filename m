Return-Path: <netdev+bounces-220853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4233EB492DB
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 17:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB776169CBB
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 15:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6CE30DD30;
	Mon,  8 Sep 2025 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="RtmUcXaD"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482E430CD80;
	Mon,  8 Sep 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344688; cv=none; b=KSOYUDXDs+eN4tNJ2He+2w1lHF/jxdAVnEDkPT2uCdixndM9/L8ZX1jSgbtokhykMfxHfbVxxmOJbX4y8GkQjkkv8BVJLHktboPz+UA3dlcOfVhHUNI0QblbpMk3NieP/qXXxa6DYdqWVmK9/bHddFSJVQ2WG6rVdExDQN8eVGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344688; c=relaxed/simple;
	bh=LEHS6QvIA0c7YbD+p0RbmrRwLnJp2+E2E+66L0QMsaA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uZLi/vAoh0uuwWmqS3FX3SV1Up2QP5/0PN3R3ClSZTdzr3CeWo7uzHoxxh5YKJZU9Lq+4eRj5Rwzbl6b5wDQe7GIOaZFSH7nrvkl5oX7yq+EwzA0i5GkCW0z9tfhKYRNUDWekJ9WIDIFGA6Grax+rSNaElnLaXbI6f8sSP433Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=RtmUcXaD; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1757344683; x=1757949483; i=efault@gmx.de;
	bh=/UYiMGDuFdnQ/wNr5ChIYTMe9NmVxYCDrcIfPLkWncQ=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RtmUcXaDZjU7YpTmBTUc/LlBiqqCA+26brnnVjmIDdX0Dtqjo0GaBxX2Pe7QQs8J
	 KHyM3sfz3jjBVartslUiOEhQ9wbWFV410tj7C8rzZTw9vaMOfJ5o8JJp98VyQVGzm
	 SyyeiCuYXfrzO0xESa6bLUVg9XN/Q3kYq2nISZfNN7tz3tdC0XpBmT+/G2hg7hZIF
	 /MhFnUJh4ez1JlHFe+fxdOlC+LHTIylKuA1VNTHZUL1lhJ2YyJfcN+URmuqBjEsN4
	 9XNP0P60TL8luNRc8bb6MgNwf79ZLTVLXEp/Cbg8Tf2LIO/pnwGigHVjzUbAkVhsL
	 3xNjYaFRV6bmrTQy3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.51]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6v3-1u6a9Y1VLn-00gTKj; Mon, 08
 Sep 2025 17:18:03 +0200
Message-ID: <ce0c55a168166ae772b6247cf16fb21f990e3482.camel@gmx.de>
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
From: Mike Galbraith <efault@gmx.de>
To: John Ogness <john.ogness@linutronix.de>, Breno Leitao
 <leitao@debian.org>,  Simon Horman <horms@kernel.org>, kuba@kernel.org,
 calvin@wbinvd.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Johannes Berg
 <johannes@sipsolutions.net>, paulmck@kernel.org, LKML
 <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, boqun.feng@gmail.com
Date: Mon, 08 Sep 2025 17:18:02 +0200
In-Reply-To: <84frcx842e.fsf@jogness.linutronix.de>
References: 
	<isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
	 <3dd73125-7f9b-405c-b5cd-0ab172014d00@gmail.com>
	 <hyc64wbklq2mv77ydzfxcqdigsl33leyvebvf264n42m2f3iq5@qgn5lljc4m5y>
	 <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
	 <4c4ed7b836828d966bc5bf6ef4d800389ba65e77.camel@gmx.de>
	 <otlru5nr3g2npwplvwf4vcpozgx3kbpfstl7aav6rqz2zltvcf@famr4hqkwhuv>
	 <d1679c5809ffdc82e4546c1d7366452d9e8433f0.camel@gmx.de>
	 <7a2b44c9e95673829f6660cc74caf0f1c2c0cffe.camel@gmx.de>
	 <tx2ry3uwlgqenvz4fsy2hugdiq36jrtshwyo4a2jpxufeypesi@uceeo7ykvd6w>
	 <5b509b1370d42fd0cc109fc8914272be6dcfcd54.camel@gmx.de>
	 <tgp5ddd2xdcvmkrhsyf2r6iav5a6ksvxk66xdw6ghur5g5ggee@cuz2o53younx>
	 <84a539f4kf.fsf@jogness.linutronix.de>
	 <7fc8a1db60de959fd22ae898e86683f57fb07be2.camel@gmx.de>
	 <84frcx842e.fsf@jogness.linutronix.de>
Autocrypt: addr=efault@gmx.de;
 keydata=mQGiBE/h0fkRBACJWa+2g5r12ej5DQZEpm0cgmzjpwc9mo6Jz7PFSkDQGeNG8wGwFzFPKQrLk1JRdqNSq37FgtFDDYlYOzVyO/6rKp0Iar2Oel4tbzlUewaYWUWTTAtJoTC0vf4p9Aybyo9wjor+XNvPehtdiPvCWdONKZuGJHKFpemjXXj7lb9ifwCg7PLKdz/VMBFlvbIEDsweR0olMykD/0uSutpvD3tcTItitX230Z849Wue3cA1wsOFD3N6uTg3GmDZDz7IZF+jJ0kKt9xL8AedZGMHPmYNWD3Hwh2gxLjendZlcakFfCizgjLZF3O7k/xIj7Hr7YqBSUj5Whkbrn06CqXSRE0oCsA/rBitUHGAPguJfgETbtDNqx8RYJA2A/9PnmyAoqH33hMYO+k8pafEgXUXwxWbhx2hlWEgwFovcBPLtukH6mMVKXS4iik9obfPEKLwW1mmz0eoHzbNE3tS1AaagHDhOqnSMGDOjogsUACZjCJEe1ET4JHZWFM7iszyolEhuHbnz2ajwLL9Ge8uJrLATreszJd57u+NhAyEW7QeTWlrZSBHYWxicmFpdGggPGVmYXVsdEBnbXguZGU+iGIEExECACIFAk/h0fkCGyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEMYmACnGfbb41A4AnjscsLm5ep+DSi7Bv8BmmoBGTCRnAJ9oXX0KtnBDttPkgUbaiDX56Z1+crkBDQRP4dH5EAQAtYCgoXJvq8VqoleWvqcNScHLrN4LkFxfGkDdqTyQe/79rDWr8su+8TH1ATZ/k+lC6W+vg7ygrdyOK7egA5u+T/GBA1VN+KqcqGqAEZqCLvjorKVQ6mgb5FfXouSGvtsblbRMireEEhJqIQPndq3DvZbKXHVkKrUBcco4MMGDVucABAsEAKXKCwGVEVuYcM/KdT2htDpziRH4JfUn3Ts2EC6F7rXIQ4NaIA6gAvL6HdD3q
	y6yrWaxyqUg8CnZF/J5HR+IvRK+vu85xxwSLQsrVONH0Ita1jg2nhUW7yLZer8xrhxIuYCqrMgreo5BAA3+irHy37rmqiAFZcnDnCNDtJ4sz48tiEkEGBECAAkFAk/h0fkCGwwACgkQxiYAKcZ9tvgIMQCeIcgjSxwbGiGn2q/cv8IvHf1r/DIAnivw+bGITqTU7rhgfwe07dhBoIdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:/SyulnuA+ZoD7q49P+nzCL85XGu4nYd2NkdhBR+xR6IAk5pRpok
 YBTtHrqk5+hiQte1NRqN2oYipL6TF6ytWaGpGwo/aG1vfWcdvxNYrwEGBPZmX8HJllRZwNQ
 crZ2pWHMviubkj+XyfJUtrExxnOGbTMRMZtBfz3gLzoD21puAiZ9E9gjdk/Ty6SVIC/8Iad
 aVMuwTJKEYq6/i9x/7s9w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:z/jhsSHSZqg=;yLpWTRN5LJNqWgR15PZu6yCWdFz
 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
 ETZA==

On Mon, 2025-09-08 at 15:36 +0206, John Ogness wrote:
>=20
> Just be aware that ->write_atomic() will be called from _any_ context
> (including scheduler and NMI) and a console implementing this callback
> must handle the message or the message is lost for that console.

What I did locally was to steal panic_in_progress() from printk.c and
use that as the barrier between immediate xmit and queue for kworker
should locking challenged parties notice IRQs are off despite selective
bending up of NETPOLL's definition of "poll".
 =C2=A0
Not perfect, but safety first seems prudent, and not bad given the
panic_on knobs available.

	-Mike

