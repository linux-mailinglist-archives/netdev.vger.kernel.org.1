Return-Path: <netdev+bounces-290728-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MMOTD1IaEGoITgYAu9opvQ
	(envelope-from <netdev+bounces-290728-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:56:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C09085B0C7D
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 10:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37DBD3017037
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 08:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CB93ACF00;
	Fri, 22 May 2026 08:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NX34oLgK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8245C33D6FC
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 08:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779440193; cv=pass; b=Fmj4P7CLFEyLDdrm/CinKZugxlOfPkse5IRHA2wZ+6p8gsK3lYCwFr6D0JSUgzscVTGv4CNcXGBChsGsMsHi4+hT8EN9imhDBbfYNr5vmoD11HNAEvickGvoJRs4hHP7bYDmH0unbITRkqjUwfAAQv66PEy+wO7uOXMefuq0wyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779440193; c=relaxed/simple;
	bh=4rrMUbEJIIgM9povErBphB6bszN6Fu8IR043oLR2Pro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A72MD6DKM0c0xTHQpLYgtlEdI5wYzvuDnTyVGhtRr5IcpZiafzpAEy+l7pZeXIkQupMjcfCzX2Bc+MleLfK3J9CVAWTFVm0LiOKoCCnFWWgk8CGHRGPIPjdYLHopk0umZnVuyaav9twAaP59OkWEYT27SbwDZg2YKhAfzur2mkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NX34oLgK; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a74ac8b40aso7436760e87.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 01:56:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779440190; cv=none;
        d=google.com; s=arc-20240605;
        b=jcIsqvZYFvDj1eAOjR6UNkWCd2hyXmunM9iHwWpg6+eTZVUZj3nqXU8d8OEpM4Q53s
         RLo5iP6VmzCsrtcPoqFA8DB3Aozvtwm55nKPebvs5HIwUflsZ2Vfol64cYnXXgNafZGN
         vwZQfDzfoeOA2aDBnq6/dJ60saJrMg0lCw59Qz90QmGTyI2cklUCoDurXWtAltCbsY4A
         gaEw2oKNjI2q5f7weuZqIb99xz2wt+myfHy97EWZamljV38mQzdHnKRtHhE8wkKATyTk
         TDZfs5AL39ggHr4lRsnABIs6ziM7YSqsnHFtUHKrykwWSLJS27Ye32U2Vy/EIvIbAjQ/
         mGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yaFACCq8ZE1W2u6S3A9eiVCMv+PJt7R0BZzbYwKupQ0=;
        fh=3Yr6D+5hRjcjqqD+TUeMMQyF9fQz7xBepeJB5RZsay0=;
        b=UYOtHgu//Hh2RNN6au1oza9igvTFVbUB1/idxrYwiH5gOLhTC0Id60zzfKWLIzsxcK
         BP5P08ut7VYLwb3GuC8+ANL9OBsBgMmSIh8fNCiS47tJYy0LI1Y4glFFdvmcuBLoxw9X
         fBuKXiSaVlmV1j6Uuu9NgCOMblS6XrvDJpUkzFe/zQ4x9sGDbVJIaUfzbzaX0orM70eU
         Q09q5Ylgj/JQ7p6XCwz1bd3X4h2KyvIHnu23kXoPsZmEa52gdbc5Ghr9h/Koiq6XgsMp
         urTmUQewQl/oWaZwKq1hdywFoDG/yknN02iFaUSJr476MkrvrAY2EZCFoBOyJucA7Mf4
         aHEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779440190; x=1780044990; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yaFACCq8ZE1W2u6S3A9eiVCMv+PJt7R0BZzbYwKupQ0=;
        b=NX34oLgKjprIH4I4VA0PZ7xAibN9XNPkVV2lq4SUn4BbV5zlKPYweCCnchvEYmug/v
         Y/MwlDRGbNODArWGBP4OUjVCKqol3WeJasVol7rifdNG3FhBio+//E02yheOAtlBt+nI
         RS4UQfU/sr6jM32fofx3+pLLGV1aDFgtCfRCX+mOvVFCc33e3drPpVg4V59nUgOB7wCC
         P/gi40SEA7WbMhIZBoRz1tbeypeEPXNve3fEz1eAeEOsC89Uv5/XuNwTw5MKuUnl+oyG
         pwOQuMuFn6yYBQ2Dbzj1n9e5DkWXtKQDu1V9QtBsQnFjs9/eUovayhei4CSazQsVZpwo
         tNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779440190; x=1780044990;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaFACCq8ZE1W2u6S3A9eiVCMv+PJt7R0BZzbYwKupQ0=;
        b=EO2L27gP4G7jUt/xe3CO5BMZ8QOhzEkq9hh+lw3Mm4un5217PnFz+pX4iZFyzYZmgg
         YkP3p49KzSY1hfbLU+YJYx9RVME41869KUgjlmJa3WfsrHcy1Px1VpSte8d6wfergmj6
         OpM1TiihigxSBRiUaWpxlIvrfTongc06nosZy2hVC0OPeVijr2w9Ueh0IdG9bbxbfh9y
         i8s7WXfuj2sj3F2OWhsXTPldQCaDS3FxjePPbU3uAIM0sWDKKdshI0kOCihXBUCGGQQa
         l4gkKJupZMDaUcZzUBTdXTQ5+jorxWfzhgkT48FLNOiBgbQ/D5IcqJ778GSkAVOyxBxo
         Mz2Q==
X-Forwarded-Encrypted: i=1; AFNElJ/hIiA9bpgIhI2p4VqGx1FBCUNvQwgAgpvIoG2v5dBojsIGzzx65LXWgpsl8lHrCjrmNFrsfb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyprFZ9YqD/iL/O2Lcox+67hlCPa9HB/Z98QTm1yfO5DDHISC5E
	bS0QLxf6yvbN+RINycMaT34vSEJ2/899R043ohidd2t1eAFutnGn2piT/RVx69LbAolhKEUUdtl
	ijE1Vbcp5avSQ7ycsOGFeYbHzSJkfcKU=
X-Gm-Gg: Acq92OGjaXgiAyVDwpLh8G4FQ+DtowEWreS3lBlrheUM/WHo6Kfnupiqc4/UgzFCo1T
	ymOPagIpxy5QVod3EMADutxd/xpWmwm5BCsKUMgt5R8HtQlVvg7rNkUdX1Op3iW4Vt+4UmsMuit
	QP7pyIVQYknFn7VabpFKNuSyFvGUxMgKY5ck5ZF3TxnBOC7W3bYQsVD9Bhf2yAsQ24VUHPGUHkT
	LPguiHCdSLkExSuvax6vNg+tPLec8Q8FGx5V5CUotVs3OGJXmAnTawGnLA54+CK1Q+EixZ0XMLr
	nZ/i1uzmGhRMqW/jHp2XA7Gr/F8n5qBF081OUCtSq597rBpmr1Y6xh3EJJYxZw==
X-Received: by 2002:a05:6512:230d:b0:5a4:6f5:6c2d with SMTP id
 2adb3069b0e04-5aa323b28d0mr931877e87.31.1779440189321; Fri, 22 May 2026
 01:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <ag75Xicuk6JwkTkC@boxer> <CAL+tcoAJ3i-WGnVx-9ASF29gPNAaP2ucw76x3ftLog-b1TPf_w@mail.gmail.com>
 <ag8ByhbrNNJaESYi@boxer> <CAL+tcoA8BkJc5jy3de3cBE69UboR66SCbLVD6B-0ffHGhXp_gw@mail.gmail.com>
 <ag8VgX2TxYIMJZB/@boxer>
In-Reply-To: <ag8VgX2TxYIMJZB/@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 22 May 2026 16:55:50 +0800
X-Gm-Features: AVHnY4JL4e7IMmtzqtx8iskPvHmzBHYpcYZL5sXLnGdy2P0JBtjNFLQxw_-vWZY
Message-ID: <CAL+tcoBy5bb2iqOfYw1Ayr85WBRRDmsPqxmquSojNgM1U21UXg@mail.gmail.com>
Subject: Re: [PATCH net v4 0/5] xsk: fix meta and publish of cq issues
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: multipart/mixed; boundary="000000000000624e6406526434ef"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290728-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	HAS_ATTACHMENT(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email,tencent.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C09085B0C7D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000624e6406526434ef
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 10:24=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, May 21, 2026 at 09:07:30PM +0800, Jason Xing wrote:
> > On Thu, May 21, 2026 at 9:00=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Thu, May 21, 2026 at 08:41:08PM +0800, Jason Xing wrote:
> > > > On Thu, May 21, 2026 at 8:24=E2=80=AFPM Maciej Fijalkowski
> > > > <maciej.fijalkowski@intel.com> wrote:
> > > > >
> > > > > On Wed, May 20, 2026 at 08:42:39AM +0800, Jason Xing wrote:
> > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > >
> > > > > > The series is the product of previous review from sashiko[1].
> > > > > >
> > > > > > 1) META
> > > > > > patch 1: address TOCTOU around metadata.
> > > > > >
> > > > > > 2) PUBLISH of CQ
> > > > > > patch 2: make sure xsk_addr->addrs[] can be published to cq whe=
n
> > > > > >          overflow occurs.
> > > > > > patch 3: keep cleaning up the continuation descs (more than 17)=
 and
> > > > > >          publish its address when overflow occurs.
> > > > > > patch 4: like patch 3, but only handles the invalid descs cases=
.
> > > > > >
> > > > > > [1]: https://lore.kernel.org/all/20260502200722.53960-1-kernelj=
asonxing@gmail.com/
> > > > > >
> > > > > > ---
> > > > > > V4
> > > > > > Link: https://lore.kernel.org/all/20260517063311.28921-1-kernel=
jasonxing@gmail.com/
> > > > > > 1. correct the description of xmit path in patch 3 (sashiko)
> > > > > > 2. move set logic into xmit path in patch 3 (Stan)
> > > > > >
> > > > > > V3
> > > > > > Link: https://lore.kernel.org/all/20260515123018.80147-1-kernel=
jasonxing@gmail.com/
> > > > > > 1. avoid breaking previous usage of sendto, and siliently handl=
e
> > > > > > overflow case (Stan, sashiko)
> > > > > > 2. add one particular exception process in patch 4 (sashiko)
> > > > > > 3. adjust the selftest to make sure it passes in either virutal=
 or
> > > > > > physical machines, which includes add usleep to support physica=
l machine.
> > > > > >
> > > > > > V2
> > > > > > Link: https://lore.kernel.org/all/20260510012310.88570-1-kernel=
jasonxing@gmail.com/
> > > > > > 1. adjust selftests (Jakub)
> > > > > > 2. add READ_ONCE in patch 1 (Stan)
> > > > >
> > > > > FWIW I still get test failures (yes with patch 5 applied). PTAL.
> > > >
> > > > Thanks for the test. But I've tried with ixgbe driver...
> > > >
> > > > I noticed there are some flaky tests which have nothing to do with =
the
> > > > series. Can you confirm that it's not caused because of the series?
> > >
> > > That explains the different results as i am using i40e/ice which have
> > > multi-buffer support whereas ixgbe does not even support mbuf at XDP.
> > > Broken tests are from mbuf cases.
> >
> > That's weird. I never expected the failed tests to be about multi-buffe=
r.
> >
> > Are they the same as the output you attached last time? Or something
> > new? Could you please share it so that I can investigate the root
> > cause?
>
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 21 FAIL: SKB ALIGNED_INV_DESC_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 33 FAIL: SKB UNALIGNED_INV_DESC_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 57 FAIL: DRV ALIGNED_INV_DESC_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 69 FAIL: DRV UNALIGNED_INV_DESC_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 93 FAIL: ZC ALIGNED_INV_DESC_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [11], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> ---------------------------------------
> not ok 94 FAIL: ZC TOO_MANY_FRAGS
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 105 FAIL: ZC UNALIGNED_INV_DESC_MULTI_BUFF
>
> # 4 skipped test(s) detected. Consider enabling relevant config options t=
o improve coverage.
> # Totals: pass:96 fail:8 xfail:0 xpass:0 skip:4 error:0
> XSK_SELFTESTS_ens259f1np1_SOFTIRQ: [ FAIL ]
> 1..108
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 21 FAIL: SKB BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 33 FAIL: SKB BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 57 FAIL: DRV BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 69 FAIL: DRV BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 93 FAIL: ZC BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
> # [is_frag_valid] expected pkt_nb [11], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> ---------------------------------------
> # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7 # 0:8=
 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> ---------------------------------------
> not ok 105 FAIL: ZC BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
>
> # 4 skipped test(s) detected. Consider enabling relevant config options t=
o improve coverage.
> # Totals: pass:96 fail:8 xfail:0 xpass:0 skip:4 error:0
> XSK_SELFTESTS_ens259f1np1_BUSY_POLL: [ FAIL ]
>
> Summary:
> XSK_SELFTESTS_ens259f1np1_SOFTIRQ: [ FAIL ]
> XSK_SELFTESTS_ens259f1np1_BUSY_POLL: [ FAIL ]

Sorry, Maciej. I managed to get one server with i40e nic but still
couldn't reproduce it. Can you try the attachment (that is the
replacement for v4-0005) instead? I removed those nasty CONT test
cases...

Really I don't think I have much time to spend on these tests which
makes me feel extremely annoyed... It's not easy to analyze the code
without a reproducer. The good news is that now I highly suspect that
this kind of CONT test cases pollute the whole cq which affects other
tests. Before I give up on the 0003/0004 patches, I'd like to hear
some advice from you. Thank you.

My original intention was to push batch xmit forward but at that time
sashiko pointed out some unrelated bugs accidentally.

Thanks,
Jason

>
> >
> > Thanks,
> > Jason
> >
> > >
> > > >
> > > > Thanks,
> > > > Jason
> > > >
> > > >
> > > > >
> > > > > >
> > > > > >
> > > > > > Jason Xing (5):
> > > > > >   xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_skb_me=
tadata()
> > > > > >   xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi-buffe=
r Tx
> > > > > >   xsk: drain continuation descs after overflow in xsk_build_skb=
()
> > > > > >   xsk: drain continuation descs on invalid descriptor in
> > > > > >     __xsk_generic_xmit()
> > > > > >   selftests/xsk: drain CQ to wait for TX completion
> > > > > >
> > > > > >  include/net/xdp_sock.h                        |  1 +
> > > > > >  net/xdp/xsk.c                                 | 44 +++++++++++=
++----
> > > > > >  .../selftests/bpf/prog_tests/test_xsk.c       | 48 +++++++++++=
--------
> > > > > >  3 files changed, 63 insertions(+), 30 deletions(-)
> > > > > >
> > > > > > --
> > > > > > 2.43.7
> > > > > >

--000000000000624e6406526434ef
Content-Type: application/octet-stream; name="test.patch.1"
Content-Disposition: attachment; filename="test.patch.1"
Content-Transfer-Encoding: base64
Content-ID: <f_mpgoomwv0>
X-Attachment-Id: f_mpgoomwv0

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3Rlc3Rf
eHNrLmMgYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy90ZXN0X3hzay5j
CmluZGV4IDc5NTBjNTA0ZWQyOC4uNGViODM1NjUyM2FhIDEwMDY0NAotLS0gYS90b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy9icGYvcHJvZ190ZXN0cy90ZXN0X3hzay5jCisrKyBiL3Rvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL2JwZi9wcm9nX3Rlc3RzL3Rlc3RfeHNrLmMKQEAgLTIwNzAsMzEgKzIwNzAs
MjUgQEAgaW50IHRlc3RhcHBfaW52YWxpZF9kZXNjX21iKHN0cnVjdCB0ZXN0X3NwZWMgKnRlc3Qp
CiAJCS8qIFZhbGlkIHBhY2tldCBmb3Igc3luY2ggdG8gc3RhcnQgd2l0aCAqLwogCQl7MCwgTUlO
X1BLVF9TSVpFLCAwLCB0cnVlLCAwfSwKIAkJLyogWmVybyBmcmFtZSBsZW4gaXMgbm90IGxlZ2Fs
ICovCi0JCXswLCBYU0tfVU1FTV9fTEFSR0VfRlJBTUVfU0laRSwgMCwgZmFsc2UsIFhEUF9QS1Rf
Q09OVER9LAotCQl7MCwgWFNLX1VNRU1fX0xBUkdFX0ZSQU1FX1NJWkUsIDAsIGZhbHNlLCBYRFBf
UEtUX0NPTlREfSwKIAkJezAsIDAsIDAsIGZhbHNlLCAwfSwKLQkJLyogSW52YWxpZCBhZGRyZXNz
IGluIHRoZSBzZWNvbmQgZnJhbWUgKi8KLQkJezAsIFhTS19VTUVNX19MQVJHRV9GUkFNRV9TSVpF
LCAwLCBmYWxzZSwgWERQX1BLVF9DT05URH0sCi0JCXt1bWVtX3NpemUsIFhTS19VTUVNX19MQVJH
RV9GUkFNRV9TSVpFLCAwLCBmYWxzZSwgWERQX1BLVF9DT05URH0sCi0JCS8qIEludmFsaWQgbGVu
IGluIHRoZSBtaWRkbGUgKi8KLQkJezAsIFhTS19VTUVNX19MQVJHRV9GUkFNRV9TSVpFLCAwLCBm
YWxzZSwgWERQX1BLVF9DT05URH0sCi0JCXswLCBYU0tfVU1FTV9fSU5WQUxJRF9GUkFNRV9TSVpF
LCAwLCBmYWxzZSwgWERQX1BLVF9DT05URH0sCi0JCS8qIEludmFsaWQgb3B0aW9ucyBpbiB0aGUg
bWlkZGxlICovCi0JCXswLCBYU0tfVU1FTV9fTEFSR0VfRlJBTUVfU0laRSwgMCwgZmFsc2UsIFhE
UF9QS1RfQ09OVER9LAotCQl7MCwgWFNLX1VNRU1fX0xBUkdFX0ZSQU1FX1NJWkUsIDAsIGZhbHNl
LCBYU0tfREVTQ19fSU5WQUxJRF9PUFRJT059LAorCQkvKiBJbnZhbGlkIGFkZHJlc3MgKi8KKwkJ
e3VtZW1fc2l6ZSwgWFNLX1VNRU1fX0xBUkdFX0ZSQU1FX1NJWkUsIDAsIGZhbHNlLCAwfSwKKwkJ
LyogSW52YWxpZCBsZW4gKi8KKwkJezAsIFhTS19VTUVNX19JTlZBTElEX0ZSQU1FX1NJWkUsIDAs
IGZhbHNlLCAwfSwKKwkJLyogSW52YWxpZCBvcHRpb25zICovCisJCXswLCBYU0tfVU1FTV9fTEFS
R0VfRlJBTUVfU0laRSwgMCwgZmFsc2UsCisJCSBYU0tfREVTQ19fSU5WQUxJRF9PUFRJT04gJiB+
WERQX1BLVF9DT05URH0sCiAJCS8qIFRyYW5zbWl0IDIgZnJhZ3MsIHJlY2VpdmUgMyAqLwogCQl7
MCwgWFNLX1VNRU1fX01BWF9GUkFNRV9TSVpFLCAwLCB0cnVlLCBYRFBfUEtUX0NPTlREfSwKIAkJ
ezAsIFhTS19VTUVNX19NQVhfRlJBTUVfU0laRSwgMCwgdHJ1ZSwgMH0sCiAJCS8qIE1pZGRsZSBm
cmFtZSBjcm9zc2VzIGNodW5rIGJvdW5kYXJ5IHdpdGggc21hbGwgbGVuZ3RoICovCi0JCXswLCBY
U0tfVU1FTV9fTEFSR0VfRlJBTUVfU0laRSwgMCwgZmFsc2UsIFhEUF9QS1RfQ09OVER9LAogCQl7
LU1JTl9QS1RfU0laRSAvIDIsIE1JTl9QS1RfU0laRSwgMCwgZmFsc2UsIDB9LAogCQkvKiBWYWxp
ZCBwYWNrZXQgZm9yIHN5bmNoIHNvIHRoYXQgc29tZXRoaW5nIGlzIHJlY2VpdmVkICovCiAJCXsw
LCBNSU5fUEtUX1NJWkUsIDAsIHRydWUsIDB9fTsKIAogCWlmICh1bWVtLT51bmFsaWduZWRfbW9k
ZSkgewogCQkvKiBDcm9zc2luZyBhIGNodW5rIGJvdW5kYXJ5IGFsbG93ZWQgKi8KLQkJcGt0c1sx
Ml0udmFsaWQgPSB0cnVlOwotCQlwa3RzWzEzXS52YWxpZCA9IHRydWU7CisJCXBrdHNbN10udmFs
aWQgPSB0cnVlOwogCX0KIAogCXRlc3QtPm10dSA9IE1BWF9FVEhfSlVNQk9fU0laRTsKQEAgLTIy
MjksNyArMjIyMyw3IEBAIGludCB0ZXN0YXBwX3Rvb19tYW55X2ZyYWdzKHN0cnVjdCB0ZXN0X3Nw
ZWMgKnRlc3QpCiAJCW1heF9mcmFncyArPSAxOwogCX0KIAotCXBrdHMgPSBjYWxsb2MoMiAqIG1h
eF9mcmFncyArIDIsIHNpemVvZihzdHJ1Y3QgcGt0KSk7CisJcGt0cyA9IGNhbGxvYyhtYXhfZnJh
Z3MgKyAyLCBzaXplb2Yoc3RydWN0IHBrdCkpOwogCWlmICghcGt0cykKIAkJcmV0dXJuIFRFU1Rf
RkFJTFVSRTsKIApAQCAtMjI0NywyMCArMjI0MSwxMSBAQCBpbnQgdGVzdGFwcF90b29fbWFueV9m
cmFncyhzdHJ1Y3QgdGVzdF9zcGVjICp0ZXN0KQogCX0KIAlwa3RzW21heF9mcmFnc10ub3B0aW9u
cyA9IDA7CiAKLQkvKiBBbiBpbnZhbGlkIHBhY2tldCB3aXRoIHRoZSBtYXggYW1vdW50IG9mIGZy
YWdzIGJ1dCBzaWduYWxzIHBhY2tldAotCSAqIGNvbnRpbnVlcyBvbiB0aGUgbGFzdCBmcmFnCi0J
ICovCi0JZm9yIChpID0gbWF4X2ZyYWdzICsgMTsgaSA8IDIgKiBtYXhfZnJhZ3MgKyAxOyBpKysp
IHsKLQkJcGt0c1tpXS5sZW4gPSBNSU5fUEtUX1NJWkU7Ci0JCXBrdHNbaV0ub3B0aW9ucyA9IFhE
UF9QS1RfQ09OVEQ7Ci0JCXBrdHNbaV0udmFsaWQgPSBmYWxzZTsKLQl9Ci0KIAkvKiBWYWxpZCBw
YWNrZXQgZm9yIHN5bmNoICovCi0JcGt0c1syICogbWF4X2ZyYWdzICsgMV0ubGVuID0gTUlOX1BL
VF9TSVpFOwotCXBrdHNbMiAqIG1heF9mcmFncyArIDFdLnZhbGlkID0gdHJ1ZTsKKwlwa3RzW21h
eF9mcmFncyArIDFdLmxlbiA9IE1JTl9QS1RfU0laRTsKKwlwa3RzW21heF9mcmFncyArIDFdLnZh
bGlkID0gdHJ1ZTsKIAotCWlmIChwa3Rfc3RyZWFtX2dlbmVyYXRlX2N1c3RvbSh0ZXN0LCBwa3Rz
LCAyICogbWF4X2ZyYWdzICsgMikpIHsKKwlpZiAocGt0X3N0cmVhbV9nZW5lcmF0ZV9jdXN0b20o
dGVzdCwgcGt0cywgbWF4X2ZyYWdzICsgMikpIHsKIAkJZnJlZShwa3RzKTsKIAkJcmV0dXJuIFRF
U1RfRkFJTFVSRTsKIAl9Cg==
--000000000000624e6406526434ef--

