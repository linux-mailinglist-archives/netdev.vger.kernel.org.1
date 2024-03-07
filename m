Return-Path: <netdev+bounces-78247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA7E8747EF
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 07:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E87C128585D
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 06:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB9A1B813;
	Thu,  7 Mar 2024 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xwf0RGng";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mH74q6W/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xwf0RGng";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mH74q6W/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652A24A22
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709792078; cv=none; b=oljQ/I9cZxfo4TYxlwvrwUAwKLZqA4URbUQv3swlrvKCMZ2jMJrXoRsEsvh3JO6dqvS4L1APL2DD0Y0KB1iRIIOJwHt0xOZ/PS1/ufIE2o+lmrZk4mWI6yN5fhSsBCnLJPrNPfZv84DdGFmzRnh5Yki/Mgh9eCg9P/vSgebtJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709792078; c=relaxed/simple;
	bh=cvWe/jLd+SxOyYgc2g5TGLVJXbTjDXiJhsNr2n8kprA=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=anw/aU2703CoSY4aY7XjnOg1oJ34+UNi/bvipryKfchut50tPIAE7GOrwpEXajIB3dJPCJ6SgnjImNloCWVCw5pjDd3Kg07DjEmt/ci95m6ZLDH4W1cYH6k7K+rwC+GYcetV/QkR5GmODGr28JJSt8sMAtKLnigJ/e1vU0xCgx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xwf0RGng; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mH74q6W/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xwf0RGng; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mH74q6W/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 804228C060;
	Thu,  7 Mar 2024 06:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709792074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=frPkwgifzQDvlROL2fiBKuqzSB+YsTDua7to2cSVZOg=;
	b=xwf0RGngaVZdeO8FXcMi+QToSj/WK0dOinqIXB9t7mbR+MsM7doYs50aSOSkLCjBl39srK
	vZy4mvUiTHPmbTK3SdZl7yudYBOz6a+LposJZ/ewcgxafTH/OtmqF69A9TXi8SP2uqdtFj
	Vj69JGsPdf0ed613jw2oeatz9R4bua8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709792074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=frPkwgifzQDvlROL2fiBKuqzSB+YsTDua7to2cSVZOg=;
	b=mH74q6W/DFsRIGSA9B2nyQfmAHSaZinehvLUoQ1EiYajrGs36axdii2dXAU4XHFw26NMJx
	sqW2PbNjkdrJFUBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1709792074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=frPkwgifzQDvlROL2fiBKuqzSB+YsTDua7to2cSVZOg=;
	b=xwf0RGngaVZdeO8FXcMi+QToSj/WK0dOinqIXB9t7mbR+MsM7doYs50aSOSkLCjBl39srK
	vZy4mvUiTHPmbTK3SdZl7yudYBOz6a+LposJZ/ewcgxafTH/OtmqF69A9TXi8SP2uqdtFj
	Vj69JGsPdf0ed613jw2oeatz9R4bua8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1709792074;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=frPkwgifzQDvlROL2fiBKuqzSB+YsTDua7to2cSVZOg=;
	b=mH74q6W/DFsRIGSA9B2nyQfmAHSaZinehvLUoQ1EiYajrGs36axdii2dXAU4XHFw26NMJx
	sqW2PbNjkdrJFUBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DD288139C3;
	Thu,  7 Mar 2024 06:14:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 6hWXI0hb6WWDLAAAn2gu4w
	(envelope-from <colyli@suse.de>); Thu, 07 Mar 2024 06:14:32 +0000
From: Coly Li <colyli@suse.de>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.300.61.1.2\))
Subject: Doesn't compile commit 0d60d8df6f49 ("dpll: rely on rcu for
 netdev_dpll_pin()")
Message-Id: <70C97E7F-767B-4E75-A454-E4468505F248@suse.de>
Date: Thu, 7 Mar 2024 14:14:11 +0800
Cc: arkadiusz.kubalewski@intel.com,
 vadim.fedorenko@linux.dev,
 netdev@vger.kernel.org
To: edumazet@google.com
X-Mailer: Apple Mail (2.3774.300.61.1.2)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 MV_CASE(0.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.60

Hi folks,

The commit 0d60d8df6f49 ("dpll: rely on rcu for netdev_dpll_pin()=E2=80=9D=
) doesn=E2=80=99t compile and see the following error message,

colyli@x:~/source/linux/linux> make
  CALL    scripts/checksyscalls.sh
  DESCEND objtool
  INSTALL libsubcmd_headers
  DESCEND bpf/resolve_btfids
  INSTALL libsubcmd_headers
  CC      net/core/dev.o
In file included from ./arch/x86/include/generated/asm/rwonce.h:1:0,
                 from ./include/linux/compiler.h:251,
                 from ./include/linux/instrumented.h:10,
                 from ./include/linux/uaccess.h:6,
                 from net/core/dev.c:71:
net/core/dev.c: In function =E2=80=98netdev_dpll_pin_assign=E2=80=99:
./include/linux/rcupdate.h:462:36: error: dereferencing pointer to =
incomplete type =E2=80=98struct dpll_pin=E2=80=99
 #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
                                    ^~~~
./include/asm-generic/rwonce.h:55:33: note: in definition of macro =
=E2=80=98__WRITE_ONCE=E2=80=99
  *(volatile typeof(x) *)&(x) =3D (val);    \
                                 ^~~
./arch/x86/include/asm/barrier.h:67:2: note: in expansion of macro =
=E2=80=98WRITE_ONCE=E2=80=99
  WRITE_ONCE(*p, v);      \
  ^~~~~~~~~~
./include/asm-generic/barrier.h:172:55: note: in expansion of macro =
=E2=80=98__smp_store_release=E2=80=99
 #define smp_store_release(p, v) do { kcsan_release(); =
__smp_store_release(p, v); } while (0)
                                                       =
^~~~~~~~~~~~~~~~~~~
./include/linux/rcupdate.h:503:3: note: in expansion of macro =
=E2=80=98smp_store_release=E2=80=99
   smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
   ^~~~~~~~~~~~~~~~~
./include/linux/rcupdate.h:503:25: note: in expansion of macro =
=E2=80=98RCU_INITIALIZER=E2=80=99
   smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
                         ^~~~~~~~~~~~~~~
net/core/dev.c:9081:2: note: in expansion of macro =
=E2=80=98rcu_assign_pointer=E2=80=99
  rcu_assign_pointer(dev->dpll_pin, dpll_pin);
  ^~~~~~~~~~~~~~~~~~
make[4]: *** [scripts/Makefile.build:243: net/core/dev.o] Error 1
make[3]: *** [scripts/Makefile.build:481: net/core] Error 2
make[2]: *** [scripts/Makefile.build:481: net] Error 2
make[1]: *** [/home/colyli/source/linux/linux/Makefile:1921: .] Error 2
make: *** [Makefile:240: __sub-make] Error 2

Can anyone help to take a look? Thanks.

Coly Li=

