Return-Path: <netdev+bounces-215022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CACB2CA8B
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 19:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76F7C1C20197
	for <lists+netdev@lfdr.de>; Tue, 19 Aug 2025 17:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B55304BBF;
	Tue, 19 Aug 2025 17:27:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134F82522B1;
	Tue, 19 Aug 2025 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755624475; cv=none; b=h3UOlhIqlfmYXsEN6QJwLETK8KGVxqI3YsTjdR9FXRQvwJ1lpK46wMWGKC4UXdJE9vG5UdyNepM6/+Jc3VjTlC5rXONUQEnYuJIyHE/E1r2kwgn+iptLvg//A2Utx1odWPPgCudNT9zAOBS4ovoED+3kAKQ0n/1IDmYVGhVeBhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755624475; c=relaxed/simple;
	bh=oumJVs5qzf00BH721SBK0mNWtZ+y5sCbArybiPDICsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VB+iPyOcIQ0ZFYhdr/oZwaYbYj6vrE2FG2EVheFvgh4bHOY5lKyiJbWdM3r4EtxKDs0X8iWi/Hs0njFpWpLbBwZm/I5SOLt16/KyedkpJa6DLbBXFaHw7SjeVQ5iLdHWVReJKQIDpsbEQ4RcdNfPwcVJoXE2dxt1OZZwl2iAiPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61a94bd82a5so444414a12.1;
        Tue, 19 Aug 2025 10:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755624471; x=1756229271;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EytGZlIufGU0jmFPyiHa4qyR0eDz07YuVh2T1VLlp1Y=;
        b=Ll0azUC64ebnXScfOIhnQ/nWF/BHbxMPhh7HfKHFL9KLkZLhX9VrFRFXTclKoLpXo/
         BbbjK6e5BCN0M8R7Ze69Ag2d8aMVK6kz5S7wxqOjNbI0oTsGASpjtINDeroXpj4eEKvw
         t0GLtyh8z6K59/pTUrj9dV2QHFjQvOdTidvya5c4j+AO+XVCAKLOjxWIjFM+iHmQ3Sq/
         Z0LP4hsMwVmgZmD0kfOz2RQuIUFO1fhlz7byXsK6yeozOrJSXirenRpP+P0r1mvisGC5
         P+7wTXLlZ7+hfzCHNhddEbKjrbwCMIDwKnBrkg+qcjNT7mU9+gAS0fOesD/fIQHnaxxo
         kbHA==
X-Forwarded-Encrypted: i=1; AJvYcCXHWVD5WRyuQZwOzYgoR5nUqqUUExTEzvKaimjcJExupNx4Wu9bQR8vO54dOlw67awtuItZLdrg@vger.kernel.org, AJvYcCXbUhIqKxFtwO5XG/Ed3OypQqd2GcZFdVquHZdMa/HT5134psHXbj6etSk+J4mkQtgHSclu8bNtCgxOVWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGg8XN4+VxbzqY3Dbvq4tvUR7C1IPf/Jt+HNI2EpB8x7PYcfXL
	52Yk360+7dZ3WDXuyq4+78hG/itGYioDyNMpEqOecBdAHfn7cuQPHvYnNglcVQ==
X-Gm-Gg: ASbGncvzcZoVHAH69V2aEt07VwsTZcfotWiriTjGt6CXfzCp6+5RG4CDgoRx+QbVgha
	tGIpemUmbv6jBpHcPzjZjVKIfIXj91a3+u42NJq9CmT4ElMhF1mdU92AF6tcuIXGZWFXqDqAp2G
	DDvSd/9Fhym95UjWTJt4lm0qqIZG48wYUKVOXtuVaqvCmHGvDwbs4Ia0lM7/HemawS0rQxcVq5W
	xWaAbU5VV34m18VamkR1OGqZWJQbVFLmhLqMSwy1ATBhmuRtPME5fuNptnJYLDOATPpgBoje6iI
	pxM6gC8lPca76BywueZw9BsVVp2gISXXeCQPev8wTSdPjsHFYMK1RjvhNZS8M6wxqCTPLwVtwqS
	WPfBw92QEA7qM84pBPI/dzBwpYchyZgwT2Q==
X-Google-Smtp-Source: AGHT+IHxe2KQjChc6Bo/8cBcvjeISTZBWrwmf/r3NhA6p9RMlhQhwEgjv9OUKz1PmKlkaAXpadi1vw==
X-Received: by 2002:a05:6402:5247:b0:615:6482:7498 with SMTP id 4fb4d7f45d1cf-61a9786a5cbmr119194a12.31.1755624471074;
        Tue, 19 Aug 2025 10:27:51 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a75794d0bsm2091155a12.46.2025.08.19.10.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 10:27:50 -0700 (PDT)
Date: Tue, 19 Aug 2025 10:27:47 -0700
From: Breno Leitao <leitao@debian.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Mike Galbraith <efault@gmx.de>, paulmck@kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, boqun.feng@gmail.com
Subject: Re: netconsole: HARDIRQ-safe -> HARDIRQ-unsafe lock order warning
Message-ID: <b2qps3uywhmjaym4mht2wpxul4yqtuuayeoq4iv4k3zf5wdgh3@tocu6c7mj4lt>
References: <fb38cfe5153fd67f540e6e8aff814c60b7129480.camel@gmx.de>
 <oth5t27z6acp7qxut7u45ekyil7djirg2ny3bnsvnzeqasavxb@nhwdxahvcosh>
 <20250814172326.18cf2d72@kernel.org>
 <3d20ce1b-7a9b-4545-a4a9-23822b675e0c@gmail.com>
 <20250815094217.1cce7116@kernel.org>
 <isnqkmh36mnzm5ic5ipymltzljkxx3oxapez5asp24tivwtar2@4mx56cvxtrnh>
 <3dd73125-7f9b-405c-b5cd-0ab172014d00@gmail.com>
 <hyc64wbklq2mv77ydzfxcqdigsl33leyvebvf264n42m2f3iq5@qgn5lljc4m5y>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <hyc64wbklq2mv77ydzfxcqdigsl33leyvebvf264n42m2f3iq5@qgn5lljc4m5y>

On Mon, Aug 18, 2025 at 05:10:24AM -0700, Breno Leitao wrote:
> On Fri, Aug 15, 2025 at 09:02:27PM +0100, Pavel Begunkov wrote:
> > On 8/15/25 18:29, Breno Leitao wrote:
> > > On Fri, Aug 15, 2025 at 09:42:17AM -0700, Jakub Kicinski wrote:
> > > > On Fri, 15 Aug 2025 11:44:45 +0100 Pavel Begunkov wrote:
> > > > > On 8/15/25 01:23, Jakub Kicinski wrote:
> > > > 
> > > > I suspect disabling netconsole over WiFi may be the most sensible way out.
> > > 
> > > I believe we might be facing a similar issue with virtio-net.
> > > Specifically, any network adapter where TX is not safe to use in IRQ
> > > context encounters this problem.
> > > 
> > > If we want to keep netconsole enabled on all TX paths, a possible
> > > solution is to defer the transmission work when netconsole is called
> > > inside an IRQ.
> > > 
> > > The idea is that netconsole first checks if it is running in an IRQ
> > > context using in_irq(). If so, it queues the skb without transmitting it
> > > immediately and schedules deferred work to handle the transmission
> > > later.
> > > 
> > > A rough implementation could be:
> > > 
> > > static void send_udp(struct netconsole_target *nt, const char *msg, int len) {
> > > 
> > > 	/* get the SKB that is already populated, with all the headers
> > > 	 * and ready to be sent
> > > 	 */
> > > 	struct sk_buff = netpoll_get_skb(&nt->np, msg, len);
> > > 
> > > 	if (in_irq()) {
> > 
> > It's not just irq handlers but any context that has irqs disabled, and
> > since it's nested under irq-safe console_owner it'd need to always be
> > deferred or somehow moved out of the console_owner critical section.
> 
> Agree. An IRQ-unsafe lock (fq lock) should not be reachable from an IRQ
> disabled code path. So, one solution might be to always send TX packets
> from a workqueue (unless it is on panic, as suggested by Calvin).

I’ve continued investigating possible solutions, and it looks like
moving netconsole over to the non‑blocking console (nbcon) framework
might be the right approach. Unlike the classic console path, nbcon
doesn’t rely on the global console lock, which was one of the main
concerns regarding the possible deadlock.

Migrating netconsole to nbcon was already on my TODO list, since nbcon
is the modern infrastructure, but this issue accelerated that
transition. I’ve put together a PoC, and so far I haven’t seen any
lockdep warnings — even when explicitly triggering printk() from
different contexts.

The new path is protected by NETCONSOLE_NBCON, which is disabled by
default. This allows us to experiment and test both approaches.


commit 9180c12086954d30b23ec2b4bbb7859aa1192aca
Author: Breno Leitao <leitao@debian.org>
Date:   Tue Aug 19 04:14:58 2025 -0700

    netconsole: Add support for nbcon
    
    Add support for running netconsole using the new non‑blocking console
    (nbcon) infrastructure.
    
    The nbcon framework improves console handling by avoiding the global
    console lock and enabling asynchronous, non‑blocking writes from
    multiple contexts.
    
    Key changes:
       * Introduce CONFIG_NETCONSOLE_NBCON (EXPERIMENTAL, depends on
         NETCONSOLE_EXTENDED_LOG && EXPERT) to enable nbcon mode.
       * Split out do_write_msg() for chunked send logic, re‑used in both
         sync and nbcon paths.
       * Add .write_thread callbacks for normal and extended netconsole when
         nbcon is enabled.
       * Provide device_lock/unlock helpers wrapping target_list_lock for
         safe nbcon integration.
       * Keep existing synchronous .write paths as the default when nbcon
         support is disabled, preserving backward compatibility.
    
    With this option enabled, netconsole can operate as a fully
    asynchronous, lockless nbcon backend, not depending on console lock
    anymore.
    
    This support is marked experimental for now until it receives wider
    testing.
    
    This patch doesn't implement optional .write_atomic callbacks,
    I initially implemented it to deferred the skbs, but, later I found that
    even printks() from inside IRQs are sent using the .write_thread()
    callback. Reading the code, I got the impression that .write_atomic
    callback is only called from an atomic context and there is a write in
    opertion, which might get interrupted (?). More on this soon.
    
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index b29628d46be9b..ec9a430aa160e 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -382,6 +382,16 @@ config NETCONSOLE_PREPEND_RELEASE
 	  message.  See <file:Documentation/networking/netconsole.rst> for
 	  details.
 
+config NETCONSOLE_NBCON
+	bool "Enable non blocking netconsole (EXPERIMENTAL)"
+	depends on NETCONSOLE
+	default n
+	help
+	  Move netconsole to use non-blocking console (nbcons).  Non-blocking
+	  console (nbcon) is a new console infrastructure introduced to improve
+	  console handling by avoiding the global console lock (Big Kernel
+	  Lock) and enabling non-blocking, asynchronous writes to the console.
+
 config NETPOLL
 	def_bool NETCONSOLE
 
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index e3722de08ea9f..5cd279e09fc8b 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1708,12 +1708,30 @@ static void write_ext_msg(struct console *con, const char *msg,
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
-static void write_msg(struct console *con, const char *msg, unsigned int len)
+static void do_write_msg(struct netconsole_target *nt, const char *msg, unsigned int len)
 {
+	const char *tmp;
 	int frag, left;
+
+	/*
+	 * We nest this inside the for-each-target loop above
+	 * so that we're able to get as much logging out to
+	 * at least one target if we die inside here, instead
+	 * of unnecessarily keeping all targets in lock-step.
+	 */
+	tmp = msg;
+	for (left = len; left;) {
+		frag = min(left, MAX_PRINT_CHUNK);
+		send_udp(nt, tmp, frag);
+		tmp += frag;
+		left -= frag;
+	}
+}
+
+static void write_msg(struct console *con, const char *msg, unsigned int len)
+{
 	unsigned long flags;
 	struct netconsole_target *nt;
-	const char *tmp;
 
 	if (oops_only && !oops_in_progress)
 		return;
@@ -1723,21 +1741,8 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 
 	spin_lock_irqsave(&target_list_lock, flags);
 	list_for_each_entry(nt, &target_list, list) {
-		if (!nt->extended && nt->enabled && netif_running(nt->np.dev)) {
-			/*
-			 * We nest this inside the for-each-target loop above
-			 * so that we're able to get as much logging out to
-			 * at least one target if we die inside here, instead
-			 * of unnecessarily keeping all targets in lock-step.
-			 */
-			tmp = msg;
-			for (left = len; left;) {
-				frag = min(left, MAX_PRINT_CHUNK);
-				send_udp(nt, tmp, frag);
-				tmp += frag;
-				left -= frag;
-			}
-		}
+		if (!nt->extended && nt->enabled && netif_running(nt->np.dev))
+			do_write_msg(nt, msg, len);
 	}
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
@@ -1917,16 +1922,69 @@ static void free_param_target(struct netconsole_target *nt)
 	kfree(nt);
 }
 
+#ifdef CONFIG_NETCONSOLE_NBCON
+static void netcon_write_ext_thread(struct console *con, struct nbcon_write_context *wctxt)
+{
+	struct netconsole_target *nt;
+
+	list_for_each_entry(nt, &target_list, list)
+		if (nt->extended && nt->enabled && netif_running(nt->np.dev)) {
+			if (!nbcon_enter_unsafe(wctxt))
+				continue;
+			send_ext_msg_udp(nt, wctxt->outbuf, wctxt->len);
+			nbcon_exit_unsafe(wctxt);
+		}
+}
+
+static void netcon_write_thread(struct console *con, struct nbcon_write_context *wctxt)
+{
+	struct netconsole_target *nt;
+
+	list_for_each_entry(nt, &target_list, list)
+		if (!nt->extended && nt->enabled && netif_running(nt->np.dev)) {
+			if (!nbcon_enter_unsafe(wctxt))
+				continue;
+			do_write_msg(nt, wctxt->outbuf, wctxt->len);
+			nbcon_exit_unsafe(wctxt);
+		}
+}
+
+static void netconsole_device_lock(struct console *con, unsigned long *flags)
+{
+	/* protects all the targets at the same time */
+	spin_lock_irqsave(&target_list_lock, *flags);
+}
+
+static void netconsole_device_unlock(struct console *con, unsigned long flags)
+{
+	spin_unlock_irqrestore(&target_list_lock, flags);
+}
+#endif
+
 static struct console netconsole_ext = {
 	.name	= "netcon_ext",
+#ifdef CONFIG_NETCONSOLE_NBCON
+	.flags	= CON_ENABLED | CON_EXTENDED | CON_NBCON,
+	.write_thread = netcon_write_ext_thread,
+	.device_lock = netconsole_device_lock,
+	.device_unlock = netconsole_device_unlock,
+#else
 	.flags	= CON_ENABLED | CON_EXTENDED,
 	.write	= write_ext_msg,
+#endif
 };
 
 static struct console netconsole = {
 	.name	= "netcon",
+#ifdef CONFIG_NETCONSOLE_NBCON
+	.flags	= CON_ENABLED | CON_NBCON,
+	.write_thread = netcon_write_thread,
+	.device_lock = netconsole_device_lock,
+	.device_unlock = netconsole_device_unlock,
+#else
 	.flags	= CON_ENABLED,
 	.write	= write_msg,
+#endif
 };
 
 static int __init init_netconsole(void)

