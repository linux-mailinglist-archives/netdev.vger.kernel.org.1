Return-Path: <netdev+bounces-46655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 554877E59C0
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 16:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EADD1C20DDC
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 15:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4381E30335;
	Wed,  8 Nov 2023 15:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4wNroml"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10372592;
	Wed,  8 Nov 2023 15:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8E3C433CC;
	Wed,  8 Nov 2023 15:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699456248;
	bh=ubRWv4gCHYtZyc/7EUxKBrb1M8Jq2gNnH2Iv89hahkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V4wNromlDBNArj+XlVHbk1Tpho83VHKj4KF3u+g8D/gDHOgmbzk9TF5F0k0bfjyJ5
	 QAa+SJ1H1vdt9z6QLXRKqy3OD3OdIvi0IIM6oR9t+f/Qou1n/kmZp3N4Ld5+Em6SUX
	 C152TcjhS6BX54Dd5mExY/uqbFmfwaVKqqV5higpeeV5QYXEeI2g8nKEM8QO7JpfaW
	 oYvzN3/QTGIj+pp0Nd5j3aFNPnFwrr1RCnhA/mv97Odgb/1aJ2xdCVJdaJgtaQHSY0
	 fqhoFzKt0Xnl3SB0XmmHuBK+2Zwe0i1mRrDK0QRCpnefsPz2sjmCZbZODNGq5w3ycl
	 CDBBZ1wKet15w==
Date: Wed, 8 Nov 2023 07:10:44 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Geoff Levand <geoff@infradead.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Masahiro Yamada
 <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org, Arnd Bergmann
 <arnd@arndb.de>, Matt Turner <mattst88@gmail.com>, Vineet Gupta
 <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Guo Ren <guoren@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Huacai Chen
 <chenhuacai@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>, Michal Simek
 <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Dinh
 Nguyen <dinguyen@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Palmer Dabbelt <palmer@dabbelt.com>, Heiko
 Carstens <hca@linux.ibm.com>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, "David S. Miller" <davem@davemloft.net>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, x86@kernel.org, Helge Deller
 <deller@gmx.de>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Timur Tabi <timur@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>, David Woodhouse
 <dwmw2@infradead.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anil S
 Keshavamurthy <anil.s.keshavamurthy@intel.com>, Kees Cook
 <keescook@chromium.org>, Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>,
 Al Viro <viro@zeniv.linux.org.uk>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-bcachefs@vger.kernel.org,
 linux-mtd@lists.infradead.org
Subject: Re: [PATCH 17/22] powerpc: ps3: move udbg_shutdown_ps3gelic
 prototype
Message-ID: <20231108071044.6abdf09e@kernel.org>
In-Reply-To: <1b3ccc4a-41f7-46ad-9c5c-5ef44a96426e@infradead.org>
References: <20231108125843.3806765-1-arnd@kernel.org>
	<20231108125843.3806765-18-arnd@kernel.org>
	<1b3ccc4a-41f7-46ad-9c5c-5ef44a96426e@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 8 Nov 2023 14:18:09 +0000 Geoff Levand wrote:
> Seems good to me.  I'll test it next chance I get.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>

Seems like this is best routed via powerpc:

Acked-by: Jakub Kicinski <kuba@kernel.org>

