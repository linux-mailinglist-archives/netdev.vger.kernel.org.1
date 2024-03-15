Return-Path: <netdev+bounces-80063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB3687CD26
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 13:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA9E1F22A8E
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 12:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF811BF44;
	Fri, 15 Mar 2024 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l/e5XwYQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PBLRRzks";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="l/e5XwYQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PBLRRzks"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400B21C683
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710505210; cv=none; b=Y7nw0DCab0Bvleh3B73laHj3QE3udu7pcHQvxjf/JubhZAPrXEgoBpqSpsSePwel4h3QTaupCwQn2fwPgiddCXDXu1tb7o5FaZWonjLiDJDY+/vdXBh68zlTZwcdwAUekCjZspiL7T+TVTksJTuzQ8w0+B2O7RzyMcRKXtZdq40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710505210; c=relaxed/simple;
	bh=KPeZyDx76mxvYGDa2wrC2NTUiKf2MV7VFEIKZt8mG1o=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=s6UFl6TGF5kTtSPL32P/s+rY7nKxG/yNmv5EaOcvv9I6i49dB7OcBVwS36jXzyuQv0dZ+k5UNBPpX6cugTpi2RKQEhXjzRHWLxahosjnvb+DlK6YCqvaRPC2Kv1BID91AmodHr+ic4b7p+/Bi5cleACtA/kYyLGvc7ouB6nKQdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l/e5XwYQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PBLRRzks; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=l/e5XwYQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PBLRRzks; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from kitsune.suse.cz (unknown [10.100.12.127])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C12E1FB63;
	Fri, 15 Mar 2024 12:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710505206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8XXc0JqGcqWsrbseMRyzJOlPdGAmOX3WbaUBfA2wjAE=;
	b=l/e5XwYQbWLxydmcJ3dP3h+TmZMhT1FLZriFlvKl3dO83ajywTRQZDoTGzQ6d37zYbpvX8
	j9HGF0DluKgK6SNCI3JeITcXniTDi/NGpVn02KIxbEYg76EHdjf9QLo8rSMv2e4s7QFrr1
	ULg98ZIPcFCZCX3QQelfGEN9v0BaH20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710505206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8XXc0JqGcqWsrbseMRyzJOlPdGAmOX3WbaUBfA2wjAE=;
	b=PBLRRzksiC1Lnz0/B1TnDNaDkpBm4oUnKH/33HfX9HG0In1bcThlAiMzrHMKAYNKIP6sOI
	WLEEVnH1KpyoexDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710505206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8XXc0JqGcqWsrbseMRyzJOlPdGAmOX3WbaUBfA2wjAE=;
	b=l/e5XwYQbWLxydmcJ3dP3h+TmZMhT1FLZriFlvKl3dO83ajywTRQZDoTGzQ6d37zYbpvX8
	j9HGF0DluKgK6SNCI3JeITcXniTDi/NGpVn02KIxbEYg76EHdjf9QLo8rSMv2e4s7QFrr1
	ULg98ZIPcFCZCX3QQelfGEN9v0BaH20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710505206;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=8XXc0JqGcqWsrbseMRyzJOlPdGAmOX3WbaUBfA2wjAE=;
	b=PBLRRzksiC1Lnz0/B1TnDNaDkpBm4oUnKH/33HfX9HG0In1bcThlAiMzrHMKAYNKIP6sOI
	WLEEVnH1KpyoexDg==
Date: Fri, 15 Mar 2024 13:20:05 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org, wireguard@lists.zx2c4.com,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, netdev@vger.kernel.org
Subject: Cannot load wireguard module
Message-ID: <20240315122005.GG20665@kitsune.suse.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.47
X-Spamd-Result: default: False [-0.47 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 R_MIXED_CHARSET(0.83)[subject];
	 BAYES_HAM(-0.00)[43.28%]
X-Spam-Flag: NO

Hello,

I cannot load the wireguard module.

Loading the module provides no diagnostic other than 'No such device'.

Please provide maningful diagnostics for loading software-only driver,
clearly there is no particular device needed.

Thanks

Michal

jostaberry-1:~ # uname -a
Linux jostaberry-1 6.8.0-lp155.8.g7e0e887-default #1 SMP Wed Mar 13 09:02:21 UTC 2024 (7e0e887) ppc64le ppc64le ppc64le GNU/Linux
jostaberry-1:~ # modprobe wireguard
modprobe: ERROR: could not insert 'wireguard': No such device
jostaberry-1:~ # modprobe -v wireguard
insmod /lib/modules/6.8.0-lp155.8.g7e0e887-default/kernel/arch/powerpc/crypto/chacha-p10-crypto.ko.zst 
modprobe: ERROR: could not insert 'wireguard': No such device
jostaberry-1:~ # modprobe chacha-generic
jostaberry-1:~ # modprobe -v wireguard
insmod /lib/modules/6.8.0-lp155.8.g7e0e887-default/kernel/arch/powerpc/crypto/chacha-p10-crypto.ko.zst 
modprobe: ERROR: could not insert 'wireguard': No such device
jostaberry-1:~ # 


