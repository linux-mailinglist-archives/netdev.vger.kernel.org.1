Return-Path: <netdev+bounces-290958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AtWN8rrEGr+fQYAu9opvQ
	(envelope-from <netdev+bounces-290958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:50:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A735BB99F
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 01:50:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8286F300E736
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 23:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4069364047;
	Fri, 22 May 2026 23:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQtxRR51"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A848034028D
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 23:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779493782; cv=pass; b=GLgI7Vde9/J4/pEUPk4gIi+d0imZi58kDIzcIYImtR565V0pY8lAImF7s5mqW0Xz/taEobrQnj1m9tzTyiOqB00zQQum8HUC2bbA38rytetKgH+NzsNQPa/m8jzmwtT26LVpfsOc6YtnsH4LafIoUX4AXI8WgWg0KxnvNe+BPAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779493782; c=relaxed/simple;
	bh=QsxD+DbwC/RtnTOWE0uh8uN10z8Jbt5LaGzLUITjlas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/hlCwv1GwlcskoTEpSpsS8Dpm3ZrfpZqgjJILUzIDnNZ+zxpUQA01Qit0OngeqRD7ZQCU7oi1ya2HfCOBj5FPAFwcZ3nC4YO2wlZdjh8Dx/E9VJOfK6IQlYYr8q63rsXOnwYjd8PE+ZN1TdqnJzfy9gtS5d59nqtbBRNbQF4hI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQtxRR51; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a877510541so9024447e87.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 16:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779493779; cv=none;
        d=google.com; s=arc-20240605;
        b=J7uAstefx/zlw6H9y+505VP0UbxQorSbRdCX6tKt3GOc0MaRQTHkk4UshueKKkqY6w
         YMNun01QG/J6v4nUXGSxZcgX/UK2n4p3wU2VHnTcs/hhSLrvGwG969bthvXgqEYHfJKp
         C2zDlBECI99h7jgA0JPUIGh0fxAf5VUa6kzIVP77PivI0b6r9p6Y2VeArfjoFDN40v+y
         vZCdbVs3OtNUd/A9/jCKW0DL3FWPFQMHetyswhf9582U69o+uHMR8VISf0GBnvl3vmHr
         GUjoPM9v7h+JOUsJe2Taro4U5B6TFnVq+84RN7GiE5ezueuWrhoXuJw8xCfaMe4KQBkA
         xcJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sIfrVRU1CyQYawHiGXu+LOyNQQdPEIoX2tk/L13b1SA=;
        fh=0quCvUKRXAtRFA+OVVqYBrprefMtyXLiw1OGLSjdf8k=;
        b=FEw3MKjfQqdQRzBQj9vMW2BzYsiPGc7/VpuedaHZ3wAWxQDAR+QxT/6qcg/y4OvKyB
         hdUDjcxsZ9NC+swc1BMvI97FSPLoojkgmv5uTAcOaO+FaId0sBIMihkxNHiodqLqBp0p
         Tq/fFEuLEHo9el+sHjMvT2a3IShJ7Dqmnv9Fv7ASlv9tJWzkkYLw62DlMKAxYlEuzBH0
         fdUbAOPUS5996BotnWkJ1l4dp1xIzpjE2+rQ361Np+uc5S5XyV8VUFvKL1nuZrdDPx6s
         nCowqAIAcAV97GyF/sP6fIwiX4tf6PGmU2cJ8Tb+NEpO2PnnRCqMIhmFeomlbX7eCxOB
         56Ew==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779493779; x=1780098579; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sIfrVRU1CyQYawHiGXu+LOyNQQdPEIoX2tk/L13b1SA=;
        b=TQtxRR51Q92cBZEVXSxQSLfdb9msELKiE4JJg4Wl3xn6tSIB3PtA0u94eEuixBd9Rc
         zGxtiVJXSc676dEjZb68/9+RkytpRhOGZvJdwRQUIXFeuIJvYMlGDS80Vo62zyXBeqI3
         MvDPRbL4kHjA+m0IfeyG839lV96ft6M6kqPH+gurRW+0VfbpCIPDq1gRtOGGR9eV2JA1
         1rh5U1ndwpkMd923UGRn0xrwjI4q7zjU8zX4GP3TjXlCk4qIwsWGFotehf1acyNSfRsU
         suzvMajEyt4u3dee372D2t2D3hn3kNUKL4m12mBAKhayanFtRgcrmIwDvoStvAqZDCOs
         2NFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779493779; x=1780098579;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sIfrVRU1CyQYawHiGXu+LOyNQQdPEIoX2tk/L13b1SA=;
        b=X8wruwpgWKLmJjDfiQKOxZ0knhLN30o2Z0HSaGeih6kjey/Nqz4900j8VpSHDLww3/
         nnPxyqS5Ff0tBzSxnbbRoKSTgRvOu1AxN6IOjMUblhoXgnnI6LKjZmqBCZ9vdbqZiF1L
         44BPsUpo5TgybE2OVVSqUWqBNzblvptKHVhghhZAj+RvHXvDG0IikT0jMKMiDaTciVL3
         p2dJjosenkBqKEsjDCEnRmI40dPLG+bc0bMk+tF05O3wb/KGiNjNoGQZ6IdBVKUAv5xb
         QOx3TZL8zrrnrepb92/AlN/BX52VopAk561xM7XjB/jBUHrEazAerrPGi84gjKrSA9eB
         Ph9A==
X-Forwarded-Encrypted: i=1; AFNElJ8Q1fOHDKvyPomaIncCg2kgJ6b1VhgUoeQ1SNG7897LTu3jzTFsBd0aCylKlSZwC9H+H6bFZ0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhEVNz8DWQPhF9fkZWneI7fINfOolSgynbfMV2LXLCD65zMcVK
	Fk1Fut1ekXwD/daTxPUDznheB1pz01H5wDLk/el9KNXXMLme7vR0hPCnXfcRRIHH9YeFSfEugoL
	r62RlHGhbAXwCXql/4Ihl1/LiIOaSB10=
X-Gm-Gg: Acq92OE7lS2B6b8081IZTPgf5DTUbHEsaMB8QZosPkifIan+VbhzEiHoFDrUE0MnEhb
	rUvGiZk4dH2MDuCv5pFwKnh/RdEbduQb1khwD6A+Cr3BLI8Z9AmrJJ2y1/Hx0gUN6MlMZe3cka6
	qUr57fkQOTNmk0rZumYMNIgvfh+ZcdsVHALS8QuuOIOlnTU3p1ZDGH5jXXSO5/5TK/Kde65hyzv
	Bj7UXComfrcGmYJnHjvtFEGX+j2x1viS6JUmB9LiFVaqgZRs1oIKFLxBO4+ey6Cb23/y5E2Gre3
	nMAQAAN2O1KB3NSrbA2ILgAReOEugxCIpBnJXbU=
X-Received: by 2002:a05:6512:6c4:b0:5a3:ff6b:cb5d with SMTP id
 2adb3069b0e04-5aa32397964mr1799614e87.19.1779493778485; Fri, 22 May 2026
 16:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520004244.55663-1-kerneljasonxing@gmail.com>
 <ag75Xicuk6JwkTkC@boxer> <CAL+tcoAJ3i-WGnVx-9ASF29gPNAaP2ucw76x3ftLog-b1TPf_w@mail.gmail.com>
 <ag8ByhbrNNJaESYi@boxer> <CAL+tcoA8BkJc5jy3de3cBE69UboR66SCbLVD6B-0ffHGhXp_gw@mail.gmail.com>
 <ag8VgX2TxYIMJZB/@boxer> <CAL+tcoBy5bb2iqOfYw1Ayr85WBRRDmsPqxmquSojNgM1U21UXg@mail.gmail.com>
 <CAL+tcoDbUkj1nJcE0HUt4Fy7FEr6oqVbpmj6utDc44KqVW+68A@mail.gmail.com> <ahChjcRmM+wEx2uq@boxer>
In-Reply-To: <ahChjcRmM+wEx2uq@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 23 May 2026 07:49:00 +0800
X-Gm-Features: AVHnY4J_qnU11S8D2XSKpmHo7_m801I1NJxMj0E76ayTRL8UzNgN5yzgbO7ei3g
Message-ID: <CAL+tcoBud6+nZ=Zeq-Ja+nnOcfwt71Z_QBofOS3qyrNt3Tkkvw@mail.gmail.com>
Subject: Re: [PATCH net v4 0/5] xsk: fix meta and publish of cq issues
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	horms@kernel.org, andrew+netdev@lunn.ch, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290958-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,lunn.ch,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 46A735BB99F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 2:34=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Fri, May 22, 2026 at 09:48:39PM +0800, Jason Xing wrote:
> > On Fri, May 22, 2026 at 4:55=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Thu, May 21, 2026 at 10:24=E2=80=AFPM Maciej Fijalkowski
> > > <maciej.fijalkowski@intel.com> wrote:
> > > >
> > > > On Thu, May 21, 2026 at 09:07:30PM +0800, Jason Xing wrote:
> > > > > On Thu, May 21, 2026 at 9:00=E2=80=AFPM Maciej Fijalkowski
> > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > >
> > > > > > On Thu, May 21, 2026 at 08:41:08PM +0800, Jason Xing wrote:
> > > > > > > On Thu, May 21, 2026 at 8:24=E2=80=AFPM Maciej Fijalkowski
> > > > > > > <maciej.fijalkowski@intel.com> wrote:
> > > > > > > >
> > > > > > > > On Wed, May 20, 2026 at 08:42:39AM +0800, Jason Xing wrote:
> > > > > > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > > > > > >
> > > > > > > > > The series is the product of previous review from sashiko=
[1].
> > > > > > > > >
> > > > > > > > > 1) META
> > > > > > > > > patch 1: address TOCTOU around metadata.
> > > > > > > > >
> > > > > > > > > 2) PUBLISH of CQ
> > > > > > > > > patch 2: make sure xsk_addr->addrs[] can be published to =
cq when
> > > > > > > > >          overflow occurs.
> > > > > > > > > patch 3: keep cleaning up the continuation descs (more th=
an 17) and
> > > > > > > > >          publish its address when overflow occurs.
> > > > > > > > > patch 4: like patch 3, but only handles the invalid descs=
 cases.
> > > > > > > > >
> > > > > > > > > [1]: https://lore.kernel.org/all/20260502200722.53960-1-k=
erneljasonxing@gmail.com/
> > > > > > > > >
> > > > > > > > > ---
> > > > > > > > > V4
> > > > > > > > > Link: https://lore.kernel.org/all/20260517063311.28921-1-=
kerneljasonxing@gmail.com/
> > > > > > > > > 1. correct the description of xmit path in patch 3 (sashi=
ko)
> > > > > > > > > 2. move set logic into xmit path in patch 3 (Stan)
> > > > > > > > >
> > > > > > > > > V3
> > > > > > > > > Link: https://lore.kernel.org/all/20260515123018.80147-1-=
kerneljasonxing@gmail.com/
> > > > > > > > > 1. avoid breaking previous usage of sendto, and siliently=
 handle
> > > > > > > > > overflow case (Stan, sashiko)
> > > > > > > > > 2. add one particular exception process in patch 4 (sashi=
ko)
> > > > > > > > > 3. adjust the selftest to make sure it passes in either v=
irutal or
> > > > > > > > > physical machines, which includes add usleep to support p=
hysical machine.
> > > > > > > > >
> > > > > > > > > V2
> > > > > > > > > Link: https://lore.kernel.org/all/20260510012310.88570-1-=
kerneljasonxing@gmail.com/
> > > > > > > > > 1. adjust selftests (Jakub)
> > > > > > > > > 2. add READ_ONCE in patch 1 (Stan)
> > > > > > > >
> > > > > > > > FWIW I still get test failures (yes with patch 5 applied). =
PTAL.
> > > > > > >
> > > > > > > Thanks for the test. But I've tried with ixgbe driver...
> > > > > > >
> > > > > > > I noticed there are some flaky tests which have nothing to do=
 with the
> > > > > > > series. Can you confirm that it's not caused because of the s=
eries?
> > > > > >
> > > > > > That explains the different results as i am using i40e/ice whic=
h have
> > > > > > multi-buffer support whereas ixgbe does not even support mbuf a=
t XDP.
> > > > > > Broken tests are from mbuf cases.
> > > > >
> > > > > That's weird. I never expected the failed tests to be about multi=
-buffer.
> > > > >
> > > > > Are they the same as the output you attached last time? Or someth=
ing
> > > > > new? Could you please share it so that I can investigate the root
> > > > > cause?
> > > >
> > > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7=
 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > > ---------------------------------------
> > > > not ok 21 FAIL: SKB ALIGNED_INV_DESC_MULTI_BUFF
> > > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7=
 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > > ---------------------------------------
> > > > not ok 33 FAIL: SKB UNALIGNED_INV_DESC_MULTI_BUFF
> > > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7=
 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > > ---------------------------------------
> > > > not ok 57 FAIL: DRV ALIGNED_INV_DESC_MULTI_BUFF
> > > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7=
 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > > ---------------------------------------
> > > > not ok 69 FAIL: DRV UNALIGNED_INV_DESC_MULTI_BUFF
> > > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7=
 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > > ---------------------------------------
> > > > not ok 93 FAIL: ZC ALIGNED_INV_DESC_MULTI_BUFF
> > > > # [is_frag_valid] expected pkt_nb [11], got pkt_nb [0]
> > > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7=
 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > > ---------------------------------------
> > > > not ok 94 FAIL: ZC TOO_MANY_FRAGS
> > > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7=
 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > > ---------------------------------------
> > > > not ok 105 FAIL: ZC UNALIGNED_INV_DESC_MULTI_BUFF
> > > >
> > > > # 4 skipped test(s) detected. Consider enabling relevant config opt=
ions to improve coverage.
> > > > # Totals: pass:96 fail:8 xfail:0 xpass:0 skip:4 error:0
> > > > XSK_SELFTESTS_ens259f1np1_SOFTIRQ: [ FAIL ]
> > > > 1..108
> > > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7=
 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > > ---------------------------------------
> > > > not ok 21 FAIL: SKB BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
> > > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7=
 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > > ---------------------------------------
> > > > not ok 33 FAIL: SKB BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
> > > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7=
 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > > ---------------------------------------
> > > > not ok 57 FAIL: DRV BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
> > > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7=
 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > > ---------------------------------------
> > > > not ok 69 FAIL: DRV BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
> > > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7=
 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > > ---------------------------------------
> > > > not ok 93 FAIL: ZC BUSY-POLL ALIGNED_INV_DESC_MULTI_BUFF
> > > > # [is_frag_valid] expected pkt_nb [11], got pkt_nb [0]
> > > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7=
 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > > ---------------------------------------
> > > > # [is_frag_valid] expected pkt_nb [10], got pkt_nb [0]
> > > > # DEBUG>> L2: dst mac: # 55# 44# 33# 22# 11# 01#
> > > > DEBUG>> L2: src mac: # 55# 44# 33# 22# 11# 00#
> > > > DEBUG>> L5: seqnum: # 0:0 # 0:1 # 0:2 # 0:3 # 0:4 # 0:5 # 0:6 # 0:7=
 # 0:8 # 0:9 # 0:10 # 0:11 # 0:0 # 0:0 # 0:0 # 0:0 # ....#
> > > > .... # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 # =
0:0 # 0:0 # 0:0 # 0:0 # 0:0 # 0:0 #
> > > > ---------------------------------------
> > > > not ok 105 FAIL: ZC BUSY-POLL UNALIGNED_INV_DESC_MULTI_BUFF
> > > >
> > > > # 4 skipped test(s) detected. Consider enabling relevant config opt=
ions to improve coverage.
> > > > # Totals: pass:96 fail:8 xfail:0 xpass:0 skip:4 error:0
> > > > XSK_SELFTESTS_ens259f1np1_BUSY_POLL: [ FAIL ]
> > > >
> > > > Summary:
> > > > XSK_SELFTESTS_ens259f1np1_SOFTIRQ: [ FAIL ]
> > > > XSK_SELFTESTS_ens259f1np1_BUSY_POLL: [ FAIL ]
> > >
> > > Sorry, Maciej. I managed to get one server with i40e nic but still
> > > couldn't reproduce it. Can you try the attachment (that is the
> > > replacement for v4-0005) instead? I removed those nasty CONT test
> > > cases...
> >
> > Ah, I think I eventually figured out a solution. Maciej, could you
> > please test the 2nd patch instead?
> >
> > This patch reworks the CONTD test cases. Cross finger.
>
> Please don't rush things here, I believe we need to think a bit more here=
.
> I have second thoughts about overall approach.
>
> My understanding wrt CQ was that it is a container that holds descriptors
> which have been successfully transmitted. Now we want to add also leftove=
r
> descriptors from broken packets, which might confuse user space sides in
> case they were relying on behavior described above.
>
> The intent is right of course as we don't want to lose UMEM descs, but I
> feel like we need a separate mechanism for that rather than putting
> invalid descs to CQ.

I don't sense anything strange here if we stick to put those
invalid/overflowed descriptors into cq. AF_XDP is only a tunnel that
transfers the data. That's it. A bit like how the physical link works,
which means it possibly drops data because of congestion.

Upper protocol is used to guarantee when to (re)transmit a packet -
the mechanism is the ACK driven in terms of TCP. TCP is absolutely
capable of finding such an abnormal thing happening by checking the
seq of incoming ack. My takeaway from this is we don't need to
deliberately design new stuff to fulfill direct and immediate
communication.

CQ works somehow as a notification that tells user space whether the
kernel receives the data from the app and handles them. Without
putting them in the CQ, the only thing for userspace to do is simply
wait.

With that said, IMHO, I cannot figure out why we need a separate queue
or something like that. Of course, a new notification that handles all
the possible/potential exceptions and contributes to the performance
of the upper layer is worth a try :) The latter is crucial.

>
> Does it make sense?
>
> Besides, even though we would stay with proposed changes, behavior betwee=
n
> modes should be aligned. Right now ZC seems to be broken in touched
> regions here - when we hit the limit of frags via pool->xdp_zc_max_segs,
> we break the loop and discard the packet, never post it to CQ and these
> descs are lost from user space POV. Then we would continue on next call
> and interpret the rest of too big packet as a separate one (clamped) and
> therefore submit corrupted packet to HW.

Right, this is how the previous selftests changes pollute the
subsequent tests after that. I think the new version of the attachment
should pass all the tests since I put all the CONTD tests separately
into another two functions? It's pointless to test those in the zc
mode.

As to the series, if no objections or any suggestions jump into the
thread, I'll post the series within a week.

Thanks,
Jason

>
> I'll be looking at ZC API but i do think we need a common approach,
> mode-agnostic.
>
> Thanks,
> Maciej
>
> >
> > Thanks,
> > Jason
> >
> > >
> > > Really I don't think I have much time to spend on these tests which
> > > makes me feel extremely annoyed... It's not easy to analyze the code
> > > without a reproducer. The good news is that now I highly suspect that
> > > this kind of CONT test cases pollute the whole cq which affects other
> > > tests. Before I give up on the 0003/0004 patches, I'd like to hear
> > > some advice from you. Thank you.
> > >
> > > My original intention was to push batch xmit forward but at that time
> > > sashiko pointed out some unrelated bugs accidentally.
> > >
> > > Thanks,
> > > Jason
> > >
> > > >
> > > > >
> > > > > Thanks,
> > > > > Jason
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Thanks,
> > > > > > > Jason
> > > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Jason Xing (5):
> > > > > > > > >   xsk: cache csum_start/csum_offset to fix TOCTOU in xsk_=
skb_metadata()
> > > > > > > > >   xsk: fix buffer leak in xsk_drop_skb() for AF_XDP multi=
-buffer Tx
> > > > > > > > >   xsk: drain continuation descs after overflow in xsk_bui=
ld_skb()
> > > > > > > > >   xsk: drain continuation descs on invalid descriptor in
> > > > > > > > >     __xsk_generic_xmit()
> > > > > > > > >   selftests/xsk: drain CQ to wait for TX completion
> > > > > > > > >
> > > > > > > > >  include/net/xdp_sock.h                        |  1 +
> > > > > > > > >  net/xdp/xsk.c                                 | 44 +++++=
++++++++----
> > > > > > > > >  .../selftests/bpf/prog_tests/test_xsk.c       | 48 +++++=
++++++--------
> > > > > > > > >  3 files changed, 63 insertions(+), 30 deletions(-)
> > > > > > > > >
> > > > > > > > > --
> > > > > > > > > 2.43.7
> > > > > > > > >
>
>

