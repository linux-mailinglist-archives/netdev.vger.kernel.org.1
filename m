Return-Path: <netdev+bounces-191187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B5DABA5C3
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 500F7A07BF9
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7981C23D28B;
	Fri, 16 May 2025 22:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HImf2Dvb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iZqFh9WJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HImf2Dvb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iZqFh9WJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192E822F746
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747433383; cv=none; b=SY71u69qc9Es5niO66XrxJ1Y6/JbECQzr2PaSTrjEE8KzlHpmvOeZNNQw4NF7ypHcKjxxv1VF4ako0rXgvUFMI9niI7mLUbkmBndWO/H3XtEFLuWTMk+TSV4HXskx9SRPMTshZuclApa9Wzt7fjWTQ4GaM53eci6uUiNOWE3IRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747433383; c=relaxed/simple;
	bh=C80rMpYCMR3dEDKxfTnXW0DIH7sXKDDe9ncWaAsFfTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UGn8XVZj38cEnTcmjjov9zw1jjGXmsBLoam36UqrVgJB5S6dFHpfuYIekVJYuIUuYr7/XJTlFF7UkcVC6FmwwD/wwFTksjXUXQSobI7S0cyh+mWIeysokeaffKo94TCQIsPy72+9EPUGoH3akeDPJpZ86o5m1aXQpQlYsEiqiD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HImf2Dvb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iZqFh9WJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HImf2Dvb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iZqFh9WJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 28D6821CC0;
	Fri, 16 May 2025 22:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747433379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VZzMbaqU9Ua8NoP9ZEp7v7UPfXh1SR33dVEDLjbZi7k=;
	b=HImf2DvbJtqJIVUe+mrKYQXvmqHFlicKWF4wv/h2wSc2a8LJejSPdQuJ4qQrk/uqPlNuaE
	ddXwOEUV4OKr3TGBrs62SwAffrfCn5MZ3tpsq2IvZ9LlfQU5l+ZyQST3QtGpPXaxr3lbxr
	CPDwq5w8QdHqtVxKs5mGHAaS/Gc3WxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747433379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VZzMbaqU9Ua8NoP9ZEp7v7UPfXh1SR33dVEDLjbZi7k=;
	b=iZqFh9WJdpqiLjjaUEr9KKIcHVwKNLpznZIwc1Sv97PFebmP6ns4d37FxEwICTsy3Vwmjz
	liCLY6nSARyabiDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747433379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VZzMbaqU9Ua8NoP9ZEp7v7UPfXh1SR33dVEDLjbZi7k=;
	b=HImf2DvbJtqJIVUe+mrKYQXvmqHFlicKWF4wv/h2wSc2a8LJejSPdQuJ4qQrk/uqPlNuaE
	ddXwOEUV4OKr3TGBrs62SwAffrfCn5MZ3tpsq2IvZ9LlfQU5l+ZyQST3QtGpPXaxr3lbxr
	CPDwq5w8QdHqtVxKs5mGHAaS/Gc3WxE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747433379;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=VZzMbaqU9Ua8NoP9ZEp7v7UPfXh1SR33dVEDLjbZi7k=;
	b=iZqFh9WJdpqiLjjaUEr9KKIcHVwKNLpznZIwc1Sv97PFebmP6ns4d37FxEwICTsy3Vwmjz
	liCLY6nSARyabiDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A012C13411;
	Fri, 16 May 2025 22:09:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lOGWGaK3J2hhGwAAD6G6ig
	(envelope-from <ematsumiya@suse.de>); Fri, 16 May 2025 22:09:38 +0000
From: Enzo Matsumiya <ematsumiya@suse.de>
To: netdev@vger.kernel.org
Cc: Enzo Matsumiya <ematsumiya@suse.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/1] net: socket: centralize netns refcounting
Date: Fri, 16 May 2025 19:09:18 -0300
Message-ID: <20250516220920.1142578-1-ematsumiya@suse.de>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.20
X-Spamd-Result: default: False [0.20 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[]

Hi,

I came up with this patch to centralize netns refcounting on kernel sockets,
because `sk_net_refcnt = !kern' is not enough anymore.

The idea is simply to remove the responsibility of a module outside of net/
to have to deal with sockets internals (cf. sk_net_refcnt_upgrade()).

It adds an anonymous enum (just for named values) SOCK_NETNS_REFCNT_* that
can be passed to __sock_create() and sk_alloc() through the @kern arg.
(this was much easier and shorter than e.g. adding another arg)

A sock_create_netns() wrapper is added, for callers who need such refcounting
(e.g. current callers of sk_net_refcnt_upgrade()).

And then, the core change is quite simple in sk_alloc() -- sk_net_refcnt is
set only if it's a user socket, or
(@kern == SOCK_NETNS_REFCNT_KERN_ANY && @net != inet_net).

I have the patches that modifies current users of sk_net_refcnt_upgrade() to
create their sockets with sock_create_netns(), if anyone wants to test or
this gets merged.

I could confirm this works only on cifs, though, by using Kuniyuki's reproducer
in [0], which is quite reliable.  Unfortunately, I don't know enough about the
other modules and/or how to trigger this same bug on those, but I'll be happy
to test it if I can get instructions.


Cheers,

Enzo


[0] - https://lore.kernel.org/linux-cifs/20241031175709.20111-1-kuniyu@amazon.com/

Enzo Matsumiya (1):
  net: socket: hint netns refcounting through @kern arg

 include/linux/net.h | 15 +++++++++++++++
 net/core/sock.c     | 10 ++++++----
 net/socket.c        | 27 +++++++++++++++++++++++++--
 3 files changed, 46 insertions(+), 6 deletions(-)

-- 
2.48.1


