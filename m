Return-Path: <netdev+bounces-46629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE1B7E5779
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 14:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0A41F220D0
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 13:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2898218C09;
	Wed,  8 Nov 2023 13:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rEbp+ATJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B5A18B04;
	Wed,  8 Nov 2023 13:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBA9AC433C9;
	Wed,  8 Nov 2023 13:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699448592;
	bh=8u/is9yGIjCKvKH616JPDZxQp4kevRf+hbF66shzciw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rEbp+ATJ8TL9tb/LlyZhDPrzGSoac6GqEtllIoknZuh3HS0PBjJ7Uq/p/fm1nXndd
	 5z95k+15Z7EVhKI2k5WFN6+zT6Dcx9LlXxtd8jGTglWA4ZtuBnSsS18mrcef8iCZsu
	 ZdGdKwnX74k42PjMs3bX54mFIVVH+UaUx6HnTk2bpX6YvZuyIqNVw1i69bKcDM+kx8
	 0QhbxPOnkVCFn+1IoJLaaDxqLtMx+o9VlbUNRag9/FUeK+64zJfYk6BL3buGhjE4FE
	 mVN9tNfFpgp0GOm3gK9WgCB6E7ONWa5a1WiaxBVRuDniK5TMae0M2X3SRFJE7qtIKk
	 B7Fo7+w6HCt9A==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Matt Turner <mattst88@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Guo Ren <guoren@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Michal Simek <monstr@monstr.eu>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Geoff Levand <geoff@infradead.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org,
	Helge Deller <deller@gmx.de>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Timur Tabi <timur@kernel.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	David Woodhouse <dwmw2@infradead.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
	Kees Cook <keescook@chromium.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-bcachefs@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: [PATCH 17/22] powerpc: ps3: move udbg_shutdown_ps3gelic prototype
Date: Wed,  8 Nov 2023 13:58:38 +0100
Message-Id: <20231108125843.3806765-18-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231108125843.3806765-1-arnd@kernel.org>
References: <20231108125843.3806765-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Allmodconfig kernels produce a missing-prototypes warning:

arch/powerpc/platforms/ps3/gelic_udbg.c:239:6: error: no previous prototype for 'udbg_shutdown_ps3gelic' [-Werror=missing-prototypes]

Move the declaration from a local header to asm/ps3.h where it can be
seen from both the caller and the definition.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/include/asm/ps3.h               | 6 ++++++
 arch/powerpc/platforms/ps3/gelic_udbg.c      | 1 +
 drivers/net/ethernet/toshiba/ps3_gelic_net.h | 6 ------
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/ps3.h b/arch/powerpc/include/asm/ps3.h
index a5f36546a052..d13d8fdc3411 100644
--- a/arch/powerpc/include/asm/ps3.h
+++ b/arch/powerpc/include/asm/ps3.h
@@ -514,4 +514,10 @@ u64 ps3_get_spe_id(void *arg);
 
 void ps3_early_mm_init(void);
 
+#ifdef CONFIG_PPC_EARLY_DEBUG_PS3GELIC
+void udbg_shutdown_ps3gelic(void);
+#else
+static inline void udbg_shutdown_ps3gelic(void) {}
+#endif
+
 #endif
diff --git a/arch/powerpc/platforms/ps3/gelic_udbg.c b/arch/powerpc/platforms/ps3/gelic_udbg.c
index 6b298010fd84..a5202c18c236 100644
--- a/arch/powerpc/platforms/ps3/gelic_udbg.c
+++ b/arch/powerpc/platforms/ps3/gelic_udbg.c
@@ -14,6 +14,7 @@
 #include <linux/ip.h>
 #include <linux/udp.h>
 
+#include <asm/ps3.h>
 #include <asm/io.h>
 #include <asm/udbg.h>
 #include <asm/lv1call.h>
diff --git a/drivers/net/ethernet/toshiba/ps3_gelic_net.h b/drivers/net/ethernet/toshiba/ps3_gelic_net.h
index 0d98defb011e..0ec7412febc7 100644
--- a/drivers/net/ethernet/toshiba/ps3_gelic_net.h
+++ b/drivers/net/ethernet/toshiba/ps3_gelic_net.h
@@ -346,12 +346,6 @@ static inline void *port_priv(struct gelic_port *port)
 	return port->priv;
 }
 
-#ifdef CONFIG_PPC_EARLY_DEBUG_PS3GELIC
-void udbg_shutdown_ps3gelic(void);
-#else
-static inline void udbg_shutdown_ps3gelic(void) {}
-#endif
-
 int gelic_card_set_irq_mask(struct gelic_card *card, u64 mask);
 /* shared netdev ops */
 void gelic_card_up(struct gelic_card *card);
-- 
2.39.2


