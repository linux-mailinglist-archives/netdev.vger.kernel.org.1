Return-Path: <netdev+bounces-243493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F1868CA2486
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 04:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 021FD3024997
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 03:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7FD824BD;
	Thu,  4 Dec 2025 03:54:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from r9110.ps.combzmail.jp (r9110.ps.combzmail.jp [49.212.36.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A621EACD
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 03:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.36.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764820480; cv=none; b=shZBK5QtgsddD/KPmD+JcLUjj6QmICTCDvEJrgD/yqLSzEarmiGRmv+a98Q17QMQv0oDoTBKmjJElK3UUTrGnPLO2XTilkdm92ITfefiwkj7b/Fnk3SeAmg6zbATvgi03CwC7PMGxZJqAUCxyxO+Pz2VJzXDGq8C7iL2d1CA1a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764820480; c=relaxed/simple;
	bh=Vu5PrLD4RQ5eWFvr+angYeZXt2Je9sHjY5obgTHQDJE=;
	h=To:From:Subject:Mime-Version:Content-Type:Message-Id:Date; b=my5ACAk8CyXiXJka2Qq2C94AT53loCTQQ+kkWpXpxbn4EKryD98CzA/9XoxumQut9NzJeOxu/JkaPJc+OZRlCJbUtZwXtPt4q01rW+bwf9esCyfjG1GqQaMmADNEmvhunNH7iGZelcXPR7DQg2CAi9hkfBOm7BpwOgf46x9soi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=k-villageinc.jp; spf=pass smtp.mailfrom=magerr.combzmail.jp; arc=none smtp.client-ip=49.212.36.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=k-villageinc.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=magerr.combzmail.jp
Received: by r9110.ps.combzmail.jp (Postfix, from userid 99)
	id A38B3188793; Thu,  4 Dec 2025 12:40:24 +0900 (JST)
DKIM-Filter: OpenDKIM Filter v2.11.0 r9110.ps.combzmail.jp A38B3188793
To: netdev@vger.kernel.org
From: =?ISO-2022-JP?B?GyRCM3Q8MDJxPFIbKEI=?= K Village<info@k-villageinc.jp>
X-Ip: 218975311502309
X-Ip-source: k85gj7ri48dnsax5u0p6gd
Precedence: bulk
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Subject: =?ISO-2022-JP?B?GyRCMk4hJiVAJXMlOUV5JE4lOSUvITwlazt2GyhC?=
 =?ISO-2022-JP?B?GyRCNkgbKEIgRkMbJEJAYkxAMnEbKEI=?=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
X-MagazineId: rix5
X-uId: 6763334240485968574188171034
X-Sender: CombzMailSender
X-Url: http://www.combzmail.jp/
Message-Id: <20251204034040.A38B3188793@r9110.ps.combzmail.jp>
Date: Thu,  4 Dec 2025 12:40:24 +0900 (JST)

　
　お世話になります。
　
　新たな事業展開をお考えの経営者様へ、
　幼児から学生、社会人、シニアまで
　幅広い世代を対象にしたボイトレ・ダンススクール事業の
　フランチャイズシステム説明会をご案内申し上げます。

━━━━━━━━━━━━━━━━━━━━━━━━
　　　
　　　12月6日（土）13:00〜14:00
　　　12月10日（水）13:00〜14:00
　　　12月17日（水）13:00〜14:00

　◆　フランチャイズ説明会
　　　幼児から学生、社会人、シニアまで！

　　　ボイトレ・ダンスのマンツーマン制スクール事業
　　　“　NAYUTAS（ナユタス）　”

　※　オーナー様にボイトレや業界知識などは不要で、
　　　未経験から開業することができます。

　◆　詳細＆申込はこちら
　　　https://nayutas-voice.biz/2500/

━━━━━━━━━━━━━━━━━━━━━━━━

------------------------------------------------

　NAYUTAS（ナユタス）はボイトレをはじめ、
　楽器やダンス、プログラミング、動画編集など、
　好きなこと・興味があることを本格的に学べる
　完全マンツーマン制レッスンのスクール事業です。

------------------------------------------------

　学習塾のように子どもや学生のみが対象になるのではなく、
　社会人やシニアも含め、3歳〜80歳の方が生徒として通われています。

　収益モデルは「生徒数×月額授業料」が売上になるサブスク型で、
　生徒数が増えることによって、売上・利益が拡大していきます。

　講師の採用や、開校後の生徒集客の確かなノウハウもあるため、オーナー様に
　ボイトレや業界知識が無くとも、未経験から開業することが可能です。

　フランチャイズ説明会を開催いたしますので、
　ご興味がありましたらご参加くださいませ。

━━━━━━━━━━━━━━━━━━━

　■　開催日程
　　　12月6日（土）13:00〜14:00
　　　12月10日（水）13:00〜14:00
　　　12月17日（水）13:00〜14:00

　■　開催方式
　　　・オンライン開催

　■　コンテンツ
　　　・入会者数の推移
　　　・ナユタスの特徴と選ばれる3つの理由
　　　・フランチャイズシステム詳細
　　　・開業費用例／収益例

　■　主催
　　　・株式会社 K Village（ナユタス運営本部）

　■　定員
　　　・5社／各回

　■　参加費
　　　・不要です

　■　詳細＆申込はこちら
　　　https://nayutas-voice.biz/2500/

━━━━━━━━━━━━━━━━━━━━━━━━━━━━
本メールが不要の方には大変失礼しました。
今後ご案内が不要な際は、下記URLにて配信停止を承っています。
https://nayutas-voice.biz/mail/
━━━━━━━━━━━━━━━━━━━━━━━━━━━━
株式会社 K Village（ナユタス運営本部）
東京都新宿区西新宿2-4-1 新宿NSビル7F
━━━━━━━━━━━━━━━━━━━━━━━━━━━━

