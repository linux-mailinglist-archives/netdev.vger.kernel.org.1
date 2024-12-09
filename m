Return-Path: <netdev+bounces-150149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B499E92BC
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 12:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F1A280C6B
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 11:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E03A21B8E7;
	Mon,  9 Dec 2024 11:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNkQh9bl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349CA1F931;
	Mon,  9 Dec 2024 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745015; cv=none; b=ShoQATTqoPwq5Kwf7PilBmH2ZrT08pOvSltRXJ4HM5fLh1+vowGTxVmIHZGVTZclXwMwI8y0Kuf1YhrRimZ4b0M23FsX6Ulph4iT2ky8QN8bEx/65sQR29JVgJM5TTwm9+oOE07NfmOLBgcNnIg2YfAfnJRt8/Z+VMbCdOALMkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745015; c=relaxed/simple;
	bh=14txjGjcIDe5vTITmnV4BciEgZYyRMnSH2sp/HSo8zo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=blICJvbvMeh9UrgSCS6pCg1IYJMgavugqbJCUyjNsBKlbqZZliF6VsVvs7RibDW2xTX5t9tFmyKjgaQEOkcgFLqWtpHRsAxbJOb09pIUls5SDtwXoS4a3qiSjjRr+s0LweEZb704XFUpnXbidai6BcAzEeX29erye9QmZVEGE8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNkQh9bl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD45DC4CEDE;
	Mon,  9 Dec 2024 11:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733745014;
	bh=14txjGjcIDe5vTITmnV4BciEgZYyRMnSH2sp/HSo8zo=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=WNkQh9bl8khGPw4ZIV31iqvj+YfC2TFaL6FY3iL13nzx4OGqkkqwQ264pog41kIpT
	 RZLwWSwVy9qLDqWyEMhtJHdH63C9o4ltIiuwWpFAKB4QBP4TaCXiVpD/NJUTOSTM57
	 Df/kAHJRKgFMb7g4vimJKjKMXi4fMnNCv+VTbwZ0nxJ9IVrtqd0wTzSpK2yF1SnUVm
	 Mx9ZzqO1mvHk46a86jEJi3uObVRXvxmE4BksbmX2g2aMgH5zwElowzWSxMovnxMeUJ
	 2ZoWdJWv2vakbVW3aw7q7k2OiS9Afqi++bQmZHBoF+Js+KwU9vEvN6+LBSE/oeWTjh
	 6C4Zj8UyYRSmA==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D04581200069;
	Mon,  9 Dec 2024 06:50:12 -0500 (EST)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Mon, 09 Dec 2024 06:50:12 -0500
X-ME-Sender: <xms:dNlWZxXbpYRS3pQeF8lm27B2t8YQi_dVACaG4KXYGLriUBa9ng4HPQ>
    <xme:dNlWZxlCxfLGXYVBk0JZESIdi_K5B7_GZimixRRiKeWwelKMYMNhFWcQaf5tKEInC
    eVpQNJCTsZqY3CJ67k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeeigddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefoggffhffvvefkjghfufgtgfesthejredtredttden
    ucfhrhhomhepfdetrhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrd
    horhhgqeenucggtffrrghtthgvrhhnpeejteeguefhffevgfehueetudevieeuueffhedv
    vefhjedthfdutdethefgfeekleenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhguodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdegqddvkeejtd
    dtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvgdpnhgspghr
    tghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvghmse
    gurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhl
    vgdrtghomhdprhgtphhtthhopehlkhhpsehinhhtvghlrdgtohhmpdhrtghpthhtohepkh
    husggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehstghhnhgvlhhlvgeslhhinhhu
    gidrihgsmhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehluhhnnh
    drtghhpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthho
    pehgvghrghesuhgtlhhinhhugidrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dNlWZ9byyyvr1VREQ3LqbmiipgoRYg42YSi4OFtL77DbjKD6x0hNjw>
    <xmx:dNlWZ0UVLpjUgyF5WVwZOUEduz02ufnWAziBVj1MdtjOeFuK8D4vbQ>
    <xmx:dNlWZ7nQmuCGRwwMKjASklN-uGGEN76aervrMk1ESS7-4F-Er1J8Dw>
    <xmx:dNlWZxex4xI2DcKJy8hNVekAs09L4Xs2qJFHv8mJbAmZSque9Rjfng>
    <xmx:dNlWZ1Gi3kF-DIncmUSCFn7XjcmyJZLQ-ulc8JzZBaLjzyXPGr2bq76P>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A586E2220072; Mon,  9 Dec 2024 06:50:12 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 09 Dec 2024 12:49:51 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Niklas Schnelle" <schnelle@linux.ibm.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Greg Ungerer" <gerg@uclinux.org>
Cc: Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
 "kernel test robot" <lkp@intel.com>
Message-Id: <3ca55478-a5a9-442b-ae4f-a0a822f786d9@app.fastmail.com>
In-Reply-To: <20241209-mcf8390_has_ioport-v1-1-f263d573e243@linux.ibm.com>
References: <20241209-mcf8390_has_ioport-v1-1-f263d573e243@linux.ibm.com>
Subject: Re: [PATCH] net: ethernet: 8390: Add HAS_IOPORT dependency for mcf8390
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Dec 9, 2024, at 11:28, Niklas Schnelle wrote:
> Since commit 6f043e757445 ("asm-generic/io.h: Remove I/O port accessors
> for HAS_IOPORT=n") the I/O port accessors are compile-time optional. As
> m68k may or may not select HAS_IOPORT the COLDFIRE dependency is not
> enough to guarantee I/O port access. Add an explicit HAS_IOPORT
> dependency for mcf8390 to prevent a build failure as seen by the kernel
> test robot.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: 
> https://lore.kernel.org/oe-kbuild-all/202412080511.ORVinTDs-lkp@intel.com/
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---

Hi Niklas,

I think your patch is correct in the sense that the I/O port
handling on m68k coldfire is only defined for the PCI bus
the port operations is this driver have nowhere to go when
PCI is disabled.

However, I suspect what you actually found is a different
preexisting bug, likely introduced in the addition of PCI
support in commits 927c28c252dc ("m68k: setup PCI support
code in io_no.h") and d97cf70af097 ("m68k: use asm-generic/io.h
for non-MMU io access functions").

As far as I can tell, the driver predates this patch and
presumably relied on inb/outb getting redirected to readb/writeb,
using the port number as a pointer (without the 
((void __iomem *) PCI_IO_PA) offset).

Note that the dev->base_addr that gets passed into inb()/outb()
is a physical address from a IORESOURCE_MEM resource,
which is normally different from both 16-bit I/O port numbers
and from virtual __iomem pointers, though on coldfire nommu
the three traditionally could be used interchangeably.

Adding Greg Ungerer to Cc, as he maintains the coldfire
platform and wrote the driver.

>  drivers/net/ethernet/8390/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/8390/Kconfig 
> b/drivers/net/ethernet/8390/Kconfig
> index 
> 345f250781c6d9c3c6cbe5445250dc5987803b1a..f2ee99532187d133fdb02bc4b82c7fc4861f90af 
> 100644
> --- a/drivers/net/ethernet/8390/Kconfig
> +++ b/drivers/net/ethernet/8390/Kconfig
> @@ -87,7 +87,7 @@ config MAC8390
> 
>  config MCF8390
>  	tristate "ColdFire NS8390 based Ethernet support"
> -	depends on COLDFIRE
> +	depends on COLDFIRE && HAS_IOPORT
>  	select CRC32
>  	help
>  	  This driver is for Ethernet devices using an NS8390-compatible
>
> ---

If I read this right, we would need something like the
patch below, to actually pass the address through ioremap()
and use readb/writeb on __iomem pointers.

      Arnd

diff --git a/drivers/net/ethernet/8390/mcf8390.c b/drivers/net/ethernet/8390/mcf8390.c
index 94ff8364cdf0..0e2a93e9ef59 100644
--- a/drivers/net/ethernet/8390/mcf8390.c
+++ b/drivers/net/ethernet/8390/mcf8390.c
@@ -44,19 +44,19 @@ static const char version[] =
  * Note that the data port accesses are treated a little differently, and
  * always accessed via the insX/outsX functions.
  */
-static inline u32 NE_PTR(u32 addr)
+static inline void __iomem *NE_PTR(void __iomem *addr)
 {
-	if (addr & 1)
+	if ((uintptr_t)addr & 1)
 		return addr - 1 + NE2000_ODDOFFSET;
 	return addr;
 }
 
-static inline u32 NE_DATA_PTR(u32 addr)
+static inline void __iomem *NE_DATA_PTR(void __iomem *addr)
 {
 	return addr;
 }
 
-void ei_outb(u32 val, u32 addr)
+void ei_outb(u32 val, void __iomem *addr)
 {
 	NE2000_BYTE *rp;
 
@@ -65,7 +65,7 @@ void ei_outb(u32 val, u32 addr)
 }
 
 #define	ei_inb	ei_inb
-u8 ei_inb(u32 addr)
+u8 ei_inb(void __iomem *addr)
 {
 	NE2000_BYTE *rp, val;
 
@@ -74,7 +74,7 @@ u8 ei_inb(u32 addr)
 	return (u8) (RSWAP(val) & 0xff);
 }
 
-void ei_insb(u32 addr, void *vbuf, int len)
+void ei_insb(void __iomem *addr, void *vbuf, int len)
 {
 	NE2000_BYTE *rp, val;
 	u8 *buf;
@@ -87,7 +87,7 @@ void ei_insb(u32 addr, void *vbuf, int len)
 	}
 }
 
-void ei_insw(u32 addr, void *vbuf, int len)
+void ei_insw(void __iomem *addr, void *vbuf, int len)
 {
 	volatile u16 *rp;
 	u16 w, *buf;
@@ -100,7 +100,7 @@ void ei_insw(u32 addr, void *vbuf, int len)
 	}
 }
 
-void ei_outsb(u32 addr, const void *vbuf, int len)
+void ei_outsb(void __iomem *addr, const void *vbuf, int len)
 {
 	NE2000_BYTE *rp, val;
 	u8 *buf;
@@ -113,7 +113,7 @@ void ei_outsb(u32 addr, const void *vbuf, int len)
 	}
 }
 
-void ei_outsw(u32 addr, const void *vbuf, int len)
+void ei_outsw(void __iomem *addr, const void *vbuf, int len)
 {
 	volatile u16 *rp;
 	u16 w, *buf;
@@ -128,12 +128,12 @@ void ei_outsw(u32 addr, const void *vbuf, int len)
 
 #else /* !NE2000_ODDOFFSET */
 
-#define	ei_inb		inb
-#define	ei_outb		outb
-#define	ei_insb		insb
-#define	ei_insw		insw
-#define	ei_outsb	outsb
-#define	ei_outsw	outsw
+#define	ei_inb		readb
+#define	ei_outb		writeb
+#define	ei_insb		readsb
+#define	ei_insw		readsw
+#define	ei_outsb	writesb
+#define	ei_outsw	writesw
 
 #endif /* !NE2000_ODDOFFSET */
 
@@ -149,7 +149,7 @@ void ei_outsw(u32 addr, const void *vbuf, int len)
 static void mcf8390_reset_8390(struct net_device *dev)
 {
 	unsigned long reset_start_time = jiffies;
-	u32 addr = dev->base_addr;
+	void __iomem *addr = ei_local->mem;
 	struct ei_device *ei_local = netdev_priv(dev);
 
 	netif_dbg(ei_local, hw, dev, "resetting the 8390 t=%ld...\n", jiffies);
@@ -190,7 +190,7 @@ static void mcf8390_get_8390_hdr(struct net_device *dev,
 				 struct e8390_pkt_hdr *hdr, int ring_page)
 {
 	struct ei_device *ei_local = netdev_priv(dev);
-	u32 addr = dev->base_addr;
+	void __iomem *addr = ei_local->mem;
 
 	if (ei_local->dmaing) {
 		mcf8390_dmaing_err(__func__, dev, ei_local);
@@ -225,7 +225,7 @@ static void mcf8390_block_input(struct net_device *dev, int count,
 				struct sk_buff *skb, int ring_offset)
 {
 	struct ei_device *ei_local = netdev_priv(dev);
-	u32 addr = dev->base_addr;
+	void __iomem *addr = ei_local->mem;
 	char *buf = skb->data;
 
 	if (ei_local->dmaing) {
@@ -255,7 +255,7 @@ static void mcf8390_block_output(struct net_device *dev, int count,
 				 const int start_page)
 {
 	struct ei_device *ei_local = netdev_priv(dev);
-	u32 addr = dev->base_addr;
+	void __iomem *addr = ei_local->mem;
 	unsigned long dma_start;
 
 	/* Make sure we transfer all bytes if 16bit IO writes */
@@ -318,7 +318,7 @@ static int mcf8390_init(struct net_device *dev)
 	};
 	struct ei_device *ei_local = netdev_priv(dev);
 	unsigned char SA_prom[32];
-	u32 addr = dev->base_addr;
+	void __iomem *addr = ei_local->mem;
 	int start_page, stop_page;
 	int i, ret;
 
@@ -403,7 +403,8 @@ static int mcf8390_init(struct net_device *dev)
 static int mcf8390_probe(struct platform_device *pdev)
 {
 	struct net_device *dev;
-	struct resource *mem;
+	struct ei_device *ei_local;
+	void __iomem *mem;
 	resource_size_t msize;
 	int ret, irq;
 
@@ -411,15 +412,11 @@ static int mcf8390_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return -ENXIO;
 
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (mem == NULL) {
-		dev_err(&pdev->dev, "no memory address specified?\n");
+	mem = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(mem)) {
+		dev_err(&pdev->dev, "failed to map resource\n");
 		return -ENXIO;
 	}
-	msize = resource_size(mem);
-	if (!request_mem_region(mem->start, msize, pdev->name))
-		return -EBUSY;
-
 	dev = ____alloc_ei_netdev(0);
 	if (dev == NULL) {
 		release_mem_region(mem->start, msize);
@@ -430,25 +427,20 @@ static int mcf8390_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, dev);
 
 	dev->irq = irq;
-	dev->base_addr = mem->start;
+	ei_local->mem = mem;
 
 	ret = mcf8390_init(dev);
-	if (ret) {
-		release_mem_region(mem->start, msize);
+	if (ret)
 		free_netdev(dev);
-		return ret;
-	}
-	return 0;
+
+	return ret;
 }
 
 static void mcf8390_remove(struct platform_device *pdev)
 {
 	struct net_device *dev = platform_get_drvdata(pdev);
-	struct resource *mem;
 
 	unregister_netdev(dev);
-	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mem->start, resource_size(mem));
 	free_netdev(dev);
 }
 


